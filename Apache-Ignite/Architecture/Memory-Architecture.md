## Source: https://ignite.apache.org/docs/latest/memory-architecture

1. General
- Ignite maintains the same binary data representation both in memory and on disk
2. Memory Segments
- Every data region starts with an initial size and has a maximum size it can grow to. 
The region expands to its maximum size by allocating continuous memory segments.

![image](https://user-images.githubusercontent.com/3434274/139373311-8b166e7d-d2f4-4beb-a380-6b214f2d4708.png)

3. Data Pages
- A data page stores entries you put into caches from the application side.
- a single data page holds multiple key-value entries in order to use the memory as efficiently as possible and avoid memory fragmentation in (4)
- If during an update an entry size expands beyond the free space available in its data page, then Ignite searches for a new data page that has enough room to take 
the updated entry and moves the entry there

4. Memory Defragmentation
- Ignite performs memory defragmentation automatically and does not require any explicit action from a user
- Over time, an individual data page might be updated multiple times by different CRUD operations. This can lead to the page and overall memory fragmentation. 
To minimize memory fragmentation, Ignite uses page compaction whenever a page becomes too fragmented.

5. Persistence
- Ignite provides a number of features that let you persist your data on disk with consistency guarantees.
