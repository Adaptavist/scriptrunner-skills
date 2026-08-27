# Troubleshooting Script Roots, NFS Shares, and IO Bottlenecks

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > troubleshooting
- Doc ID: doc-sr4js-441364961
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-script-roots-nfs-shares-and-io-bottlenecks

ScriptRunner generally performs well across a variety of hosting infrastructures. However, as more customers use cloud providers such as AWS or Azure for their Data Center infrastructure, we have received an increasing number of support tickets. These tickets are from customers who hit performance problems because ScriptRunner gets blocked while trying to read from the Network File System (NFS) where the scripts were stored.

Symptoms may include stuck threads or high CPU usage after changing script files. If you take an Atlassian Support Zip and see blocked threads that include `com.onresolve.scriptrunner.runner.LazyInitInputStream` in the stack trace, or a very large number of threads in the RUNNABLE state which pass through that class, that's a good indication you may be facing an IO bottleneck. This does not happen in every NFS setup, but it can happen depending on the environment.

Troubleshooting these issues can be very complicated, since NFS has a wide array of options which can optimize for different scenarios (see [the NFS documentation](https://linux.die.net/man/5/nfs)). Atlassian provide some good [guidance on optimizing shared storage for Atlassian Data Center](https://success.atlassian.com/solution-resources/agile-and-devops-ado/platform-administration/shared-storage-for-atlassian-tools) to help remove some of the guesswork.

## Things to try first

Before attempting any workarounds, such as the rsync workaround documented below, it is important to consider whether alternatives might be preferable. Deciding which option is best for you is a judgment call you'll have to make. However, consider them carefully before implementing the workaround using `rsync` described below, as there are tradeoffs.

### Diagnosing your NFS infrastructure

The best way to diagnose the problem is to thoroughly investigate and manually diagnose performance problems with your NFS using Atlassian's tuning guidance. Atlassian provides comprehensive guides on this subject for a reason, and we aren't the only plugin that can encounter these limits at scale.

#### Quick diagnostic

Atlassian provides a support tools jar file that can be used to diagnose the performance of the shared home directory.

We have an [example script](https://www.scriptrunnerhq.com/help/example-scripts/home-directories-filesystem-speed-benchmark-onPrem) that you can run from the Script Console to diagnose performance problems. For more details on that benchmark jar and how it works, the [Jira Guy provides a good write-up](https://thejiraguy.com/2020/09/30/is-jira-feeling-slow-lately/) under the Fileshare/Disk Speed header. It uses a diagnostic jar from Atlassian to check how fast your filesystem is. A basic outline of how to interpret the numbers it spits out is reproduced here:

Statistic

Excellent

OK

Bad

Open

< 40,000

40,000 – 150,000

\> 150,000

Read/Write

< 40,000

40,000 – 100,000

\> 100,000

Close

< 20,000

20,000 – 100,000

\> 100,000

Delete

< 50,000

50,000 – 300,000

\> 300,000

#### Going deeper

If you notice that one of the numbers from the above diagnostic is poor, you can dig deeper into Atlassian's recommendations on how to setup an NFS share for optimal performance.

-   Atlassian's [overview on shared storage](https://success.atlassian.com/solution-resources/agile-and-devops-ado/platform-administration/shared-storage-for-atlassian-tools) is the best place to start.
-   Their [overview of performance issues](https://confluence.atlassian.com/jirakb/troubleshoot-performance-issues-in-jira-server-336169888.html) has some good quick notes on troubleshooting disk speed.
-   Their guide [on benchmarking your network filesystem](https://support.atlassian.com/bitbucket-data-center/kb/testing-nfs-disk-access-speed-for-bitbucket-data-center-and-git-operations/) using [bonnie++](https://linux.die.net/man/8/bonnie++), while written specifically for Bitbucket DataCenter, is broadly applicable to any Atlassian product using an NFS for the shared home directory.

If you're still having trouble with ScriptRunner threads getting stuck while trying to read script files, despite your NFS system lining up with Atlassian's recommendations for your instance size, you may need to consider alternatives for your scale.

### Try simplifying your scripts

ScriptRunner is powerful and it's worth asking if you can bypass any load problems you're facing by reducing the complexity of your ScriptRunner configuration. Achieving this can be challenging, but it has proven helpful in many cases. It might involve one of the following approaches:

-   Remove copy-pasted copies of a listener that runs in dozens of projects. Instead have one listener that can accomplish the same work.
-   Replace your own custom-rolled suite of utility classes with calls to [HAPI.](https://docs.adaptavist.com/sr4c/latest/hapi) Reducing the complexity of your scripts' imports and inheritance can reduce the IO from importing a custom class from the script roots.
-   Make sure that the business need for a given script still exists and hasn't been superseded by a newer feature of ScriptRunner or the Atlassian host application itself.

### Configure a custom script root with faster IO

Many customers are constrained in how much they can pay for a fast NFS for their entire Atlassian application's shared home. However, script files are generally quite small and not frequently written to. Therefore, you might be able to use a much faster network share for your scripts by setting it up as a [custom script root](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots).

### Use a script plugin

You can try storing your scripts in a [Script Plugin](#). This makes deploying changes to scripts a bit more difficult, but may help bypass some of the read/write problems that managing the scripts in a sub-optimal NFS share can cause.

### Move to cloud

If all of this seems like a lot to manage yourself, we offer solutions to help alleviate the burden. If you've encountered these scaling limits and cannot resolve them on your own, you should consider [migrating to Atlassian Cloud](#).

#### Not ready for cloud?

If you're not ready to begin that journey, consider contacting [Adaptavist's Managed Services](https://www.adaptavist.com/solutions/managed-services) team to host your Data Center instance.

## Workaround: Synchronizing script roots from a distinct NFS

You've considered all of the above alternatives and confirmed that your NFS mount is configured correctly according to Atlassian's guidelines and is performing well. Yet, ScriptRunner continues to encounter stuck threads when attempting to read from your script root.

To bypass this issue entirely, make sure that each node in your Atlassian Data Center setup can read your script files from a local filesystem, rather than a network filesystem without performance issues.

For a single-node instance of an Atlassian Data Center app, no special synchronization is required. On a more typical multi-node setup this creates a new problem you have to solve. You need to make sure the multiple nodes in your Data Center cluster synchronize their changes to your script code with some shared source of truth. There are lots of ways to do that. This guide will describe a fairly simple way using the [rsync](https://linux.die.net/man/1/rsync) utility.

Please note that supporting and maintaining this workaround is beyond the scope of [ScriptRunner's Support Policy](https://www.scriptrunnerhq.com/support-policy). This guide serves as a starting point for administrators addressing environmental performance issues beyond their control. For example, Jira, Confluence, and Bitbucket administrators may have access to configure file synchronization on the servers where their Atlassian product runs, but not have access to adjust the network topology to match Atlassian's recommendations. You may be considering one of the alternative approaches, above, but need to eliminate your NFS as a cause in order to prove to your system administrators that the bigger fix is worth the effort.

This is a basic guide for how you might bypass the problem using `rsync`. There are a host of alternative file synchronization utilities that you could use, depending on your system, so you are not limited to `rsync`. If you know and love another utility, particularly one with good bi-directional support like [unison](https://github.com/bcpierce00/unison), [syncthing](https://syncthing.net/), or [osync](https://github.com/deajan/osync), feel free to use that instead.

### Basic outline

Below is a basic outline of the steps in this guide:

1.  **Create separate NFS directory**: Ensure that the NFS directory used for synchronization is not the default script root located in `$SHARED_HOME/scripts`. Instead, create a separate NFS directory that you manage. This directory can still reside within the shared home but must be distinct from the default script root that ScriptRunner uses at `$SHARED_HOME/scripts`.
2.  **Local Script Root**: Define a new script root that points to a local path on each node. Refer to the [ScriptRunner Script Roots Documentation](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots) for detailed instructions on configuring script roots.
3.  **Setup bi-directional sync**: Using `rsync`, synchronize changes between your NFS directory and your local script root.

### Step-by-step instructions

#### Step one: Set up the NFS directory

Create a custom directory on your NFS server. This directory will serve as the source for synchronization. For this document, we'll assume a path of `/nfs/custom_script_root` from the perspective of the nodes, but you may use any valid path so long as you update the commands accordingly.

Move your script files from their current home in the default script root ($SHARED\_HOME/scripts) to this new directory.

#### Step two: Configure the local script root

On each node, configure a script root to point to a local directory where scripts will be synchronized. See the [Script Roots Documentation](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots) for detailed instructions on configuring script roots.

For this document, we'll use the path `/local/scripts`. Again, you may change this so long as you're consistent.

#### Step three: Set up bi-directional `rsync`

To enable bi-directional synchronization, you will need to set up `rsync` to sync changes from the NFS directory to the local script root and vice versa. We'll provide the individual commands first so that you can check them by running them from each node to ensure they work as expected.

##### Synchronize from NFS to local

Use the following `rsync` command to synchronize scripts from the NFS directory to the local script root:

```
rsync -avz /nfs/custom_script_root/ /local/scripts
```

\- \*-a\*: Archive mode (preserves permissions, timestamps, symbolic links, etc.)  
\- \*-v\*: Verbose output  
\- \*-z\*: Compress data during transfer

##### Synchronize from local to NFS

To ensure that changes made locally on the node are reflected in the NFS directory, use the following `rsync` command:

```
rsync -avz /local/scripts/ /nfs/custom_script_root
```

#### Step four: Automate synchronization

To keep the directories in sync automatically, you can set up a cron job on each node. Below is an example cron job that runs every minute. You may want to change the frequency, depending on the frequency you update your scripts and the speed of the job.

```
# The u flag here ensures that rsync only updates files that are older on the destination.
# We also avoid using the v flag, since there's no need for verbose logging in the CRON job running in the background, though you may add that back for troubleshooting purposes at your discretion.

*/1 * * * * rsync -auz /nfs/custom_script_root/ /local/scripts && rsync -auz /local/scripts/ /nfs/custom_script_root
```

This explanation is simplified in key areas. Bi-directional synchronization is complicated. While we could add the `--delete`  flag from rsync, that could lead to new files being deleted, depending on the order of jobs run on each node. The reverse could happen as well, wherein you _want_ a file to be deleted, but the synchronization propagates in the wrong order. To address this, you can create separate services to watch for and manage deletions (using utilities like [inotifywait](https://linux.die.net/man/1/inotifywait)) or using a file sync utility that handles bi-directional synchronization concerns. It is your responsibility to maintain this setup to meet your requirements. Ideally, this workaround would only remain in place long enough to demonstrate that IO speed on the shared home was, in fact, the problem.

#### Step five: Instruct script authors

Ensure that all script authors are aware of the new setup and instruct them to write scripts to your new script root (`/local/scripts` ). This will ensure that their changes are synchronized across all nodes.

## Final notes

Manually synchronizing your script roots to a local filesystem introduces complexity that we aim to avoid adding to your workflow. This is why we made improvements under the hood in [6.54.0](https://docs.adaptavist.com/sr4js/latest/release-notes/release-6-x#performance-improvements) and [7.2.0](https://docs.adaptavist.com/sr4js/latest/release-notes/release-7-x#720) to reduce the load on filesystems that came from the Groovy compiler and our use of it. For customers who are still facing issues, we strongly encourage you to look at the alternatives first. 

We recognize that this guide may be useful as a temporary workaround for demonstrating that the problem isn't with ScriptRunner itself, but with the Network File System ScriptRunner needs to read from.
