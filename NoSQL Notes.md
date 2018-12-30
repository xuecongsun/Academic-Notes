## Lecture 1 - Big Data & NoSQL Intro

### Big Data

1. Intro
   - Web companies are producing high volume of low-value data and that causes traditional methods and searches to be very expensive.
   - Big data:
     - web data: consumer click trail
     - scientific projects: numerous times of experiments
     - commercial/financial transactions: sell and buy stock thousand times per second
     - social network: facebook, twitter, google
     - health information
   - Players:
     - Research, Business, Other sectors (healthcare, insurance, customer service, government, finance)
2. Characteristics of Big Data (Five Vs)
   - Volume (exponential increase in size and count), Velocity (speed at which data is created), Variety (multi-dimention and format), Veracity (truthfulness & integrity. whether you can trust it), Value (worth)  
   - Findability (database, whether you can retrieve stuff, is the data shared) & Availability(is the data shared)
3. 4 Types of big data
   - Archetypal
     - science projects, business/industry, government
     - all characteristics high except for variety
   - Crowd-Sourced
     - social media, recommenders, web commerce
     - Velocity is bursty, veracity is mixed, values is ephemeral, availability is short-term. rest is high
   - Long-tail
     - science projects (small organizations), personal, government (internal and unpublished)
     - Velocity is low, veracity is low (till proven), value is unknown. Finadability and availability are none because they are hidden and not advertised. And they are in local disks and tapes (dark data)
     - Small science projects, how to make their data easily available for the rest of the world to access
   - Sensor Streams
     - internet of things, smart cities, health
     - Veracity is mixed (till proven), value is huge, findability is none and availability is low (as the data is low sharing)

### NoSQL

1. Why NoSQL? (What kind of problems are NoSQL trying to solve?) Pros of NoSQL?
   - Data's volume and velocity has increased exponentially - NoSQL is Able to store massive amounts of data (volume)
   - Economical - RDBM requires expensive proprietary servers and storage systems whereas NoSQL models are easy and cheap to install. Cost can increase linearly with storage, comparing with SQL cost which is a n square problem, since we need to maintain communication among different tables.(volume)
   - For data that is inconvenient to store in the form of tables or have other kind of relationships between records. For non-relational and schema-less data model,don't force data to do something they aren't designed for. Flexible. Capable of storing documents, graphs (variety)
   - We don't need 100% accuracy of value for the big data we want to store (veracity)
   - Highly scalable - easy to scale out when it comes to commodity clusters. NoSQL makes use of new nodes which make them transparent for expansion
   - Low latency and high performance
   - key-value storage enable fast retrieval and storage. Column oriented storage makes aggregation much simpler
2. Cons of NoSQL:
   - Less mature, primitive or ad hoc data modelling. 
   - Lazy or outright indifferenct attitude towards concurrency
   - Database architecture can be specific to one kind of problem
   - less support, business intelligence and analytics
3. NoSQL Growup:
   - From no concurrency guarantees (memcached) to weak guarantees (cassandra) to ACID (FoundationDB)
   - Less primitive data models: from key-value(cassandra) to Document(MongoDB) to Graph (Neo4j) and Relational(Hive)
   - Commercial support available
4. Why not RDBMS
   - Slow insertions - side effect of perfectly predictable insertion (big data we don't have to get all operations in the exact order. Unlike banking, we need all operation transaction to be in the right order) 
   - Data model may be  a forced fit - such as use a recursive table relationships to represent a graph
   - Commercial RDBMS are expensive and Open Source ones are not terribly good
5. ❓Pros of SQL compared with NoSQL
   - Accuracy
   - Well-defined standards - long established are used by the SQL databases that is being used by ISO and ANSI. There are no standards adhered by the non-SQL databases
   - Portability - SQL can be used in PCs, servers, laptops even sore of the mobile phones
   - No coding needed and interactive language
   - Multiple data views: uses can make different views of database structure and databases for different users
6. RMDB adapts
   - Horizontal scaling
   - ACID with less overhead
   - Drop SQL language
   - Column stores or other data storage strategies
   - Relaxed schema - XMlL and JSON are first-class types
7. Assumptions then and now
   - You will never be able to intall enough RAM to hold entire database
   - More than 1 transaction at a time (Multiple servers, one core for each server and one transaction at a time)
   - Analytically decide if 2 transactions conflict ahead of time is slow(don't use locks. CPU are super fast now. If conflict run one at a time)
8. Hardware improvements:
   - Faster network, SSD and RAM become cheaper
9. Real Speed Boost - Parallelism
   - break up the problem into smaller pieces, have lots of small and cheap computers solve their piece and combine the results. This could be across many processors in one computer or across many computers
   - One big machine many processors doesn't performance as well. So solution is tons of small machines that share nothing but the network (cluster). Every machine runs its own copy of OS with no contention
10. The cloud:
    - Relies on virtualization to make one CPU look like many
    - Rent capacity by the hour
11. Speed up
    - Because machines need coordination among themselves, so the speed doesn't increase linearly as resources grow. More likely they get diminishing returns to scale. Superlinear speedup? Usually because larger ram is thrown at the problem
12. Lock
    - Ensure a given resource is used by one running task at a time. Keeps 2 tasks from writing the same piece of data at the same time -- zookeeper for locks on shared clusters
13. Network (determines how algorithm should be crafted, how much capacity needs to be built)
    - Point-to-point network: connect every machine to every machine (expensive)
    - Busses? only connect with their respective nodes
    - Compromise solution - top of rack - network switches
    - Fat tree networks - not widely used except maybe at google
14. Key-Value stores
    - instead of index, NoSQL db uses key-value stores
15. Column-orientated storage - make aggregate function very fast
16. Document database:
    - stores data as a flattened object, almost always json
    - great for saving javascript or python object and load them again
17. Graph database:
    - like who your friends are, who you message a lot
    - Hard for RMDB cos partition is hard - you don't know how and where to separate the data

## Lecture 2 - Neo4j

1. Purpose. When to use it?

   - graph database, for data that is connected in networks and relationship (social network, human genome)
   - data is stored in nodes and edges but what values held in nodes and edges are not enforced

2. Pros and Cons

   - Con: Requires non-trivial organization on how to organize the Neo4j database and everyone has to closely adhere to it. Unlike SQL has very strict rules to standardize and follow. No fixed constraints meaning we need organizational discipline 

3. What is Neo4j:

   - schema free, bottom-up data model design
   - embeddable (Embed Neo4j kernel into sth else) and server
   - Full ACID transactions: Atomicity, consistency, isolation and durability
   - Scaling vertically, not horizontally, so not really for big graph

4. What is ACID

   - ACID is a set of properties that you would like to apply when modifying a database
   - Atomicity means that you can guarantee that all of a transaction happens or none of it does. Any failure won't allow you to be in a state in which only some of the related changes have happened
   - Consistency means that you guarantee that your data will be consistent. None of the constraints you have on realted data will ever be violated
   - Isolation means that one transation can't read data from another transaction that is not yet completed. If two transactions are executing concurrently, each one will see the world as if they were executing sequentially and if one needs to read data that is written by another, it will have to wait until the other is finished
   - Durability means that once a transaction is complete, it is guaranteed that all of the changes have been recorded to a durable medium (such as a hard disk).

5. Horizontal and Vertical Scaling

   - Horizontal scaling (distributed programming): you scale by adding more machines into your pool of resources. Each node only contains part of the data. With horizontal scaling is often easier to scale dynamically by adding more machines to the existing pool
   - Vertical scaling (multicore architecture) means that you scale by adding more power to an existing machine (CPU, RAM). Data resides on a single node and scaling is done through multi-core. Spreading the load between the CPU and RAM resources of that machine. Vertical scaling is often limited to the capacity of a single machine, scaling beyond that capacity often involves downtime and comes with an upper limit. Buy a big server. Usually how much RAM you can add is bounded by the server itself. 
   - Horizontal scaling: Cassandra, MongoDB
   - Vertical scaling: MySQL, neo4j. Use vertical scaling when you have highly coordinated simulation when every data is highly related with other data. So all data needs to be in memory.

   - hadoop and spark - both horizontal and vertical scaling
   - When to horizontally scale > vertically scale: depends on scalability/performance. 
     - Scale out allows you to combine the power of multiple machines into a virtual single machine with the combined power of all of them together. You are not limited to the capacity of a single unit. But in the scale up scenario, you have a hard limit, the scale of hardware that you are currently using
     - Continuous availability/redundancy: failure is inevitable, having one big sustem is going to lead to a single point of failure and recovery process could be long
     - Cost/performance flexibility: you want to have the flexibility to choose the optimal configuration setup at any given time or opportunity to optimize cost/performace. If your system is designed for scale=up only, then you are pretty much locked into a certain mimum price driven by the hardware that you are using
     - Continuous upgrades: building an application as one big unit is going to mkae it harder or even impossible to add or change pieces of code individually without brining the entire system down
     - Geographical distribution: cases where an application needs to be spread across data centers of geographical location to handle disaster recovery scenarios or reduce geographical latency.
   - Cons of scaling out:
     - licensing fees are more. utility costs such as cooling and electricity are high. Bigger footprint in data center. more networking equipment such as routers and switches may be needed
   - Pros of scaling up:
     - Consumes less power as compared to running multiple servers
     - Admin efforts reduced as you need to handle and manage just one system.
     - Cooling costs are less than horizontal scaling
     - Reduced software costs
     - Implementation isn't difficult
   - Cons of scaling up:
     - greater risk of hardward failure
     - LImited scope of upgradeability in the future
   - How does realtional database realize horizontal scaling: really hard to control transcation semantics, hard to do join as they need communication. Therefore, we need to decide how to partition first and break the table assign to nodes.

6. Property Graph Model:

   - Node is a person for example, edge is their relationship

7. Three ways to use Neo4j

   - Call it from python, Java, Ruby, C, C++ programs
   - Rest interface: an interface based on making artificial web requests to special URLs
   - Built-in web-based GUI

8. Logical architecture

   - Filesystem(save and write) - IO system (input/output) - Caches - Core API (Traversal framework - node to node searching, graph matching - pattern matching, looking for subset of a graph that meets a set of criteria) - Rest API - Web GUI 

9. Indexing a graph

   - graphs are their own indexes. Don't index every node or relationship - may slow down or take much space
   - Lucene - open source text searching engine. Default method of indexing in Neo4j. Treats everything as strings. Very fast text searching

10. Other representation of big graph:

    - Adjacency matrix




## Lecture 3 - Amazon's Dynamo

### CAP Conjecture

1. It is impossible for a web service to provide following 3 guarantees: consistency, availability, partition-tolerance. You can only have 2 of these

   - Consistency - any means of access returns the same stored value for data. Every read receives the most recent write or error

   - Availability - no matter what, the database is always ready to accept read and write requests. Every request receives a non-error response, without a guarantee that it contains the most recent write

   - Partition-tolerance - if part of the network goes down, the system stays up and also no data is lost.The system continues to operate despite an arbitrary number of messages being dropped (or delayed) by the network between nodes

   - When choosing consistency over availability, the system will return an error or a time-out if particular information cannot be guaranteed to be up to date due to network partitioning. When choosing availability over consistency, the system will always process the query and try to return the most recent available version of the information, even if it cannot guarantee it is up to date due to network partitioning.

   - In the absence of network failure – that is, when the distributed system is running normally – both availability and consistency can be satisfied.

     CAP is frequently misunderstood as if one has to choose to abandon one of the three guarantees at all times. In fact, the choice is really between consistency and availability only when a network partition or failure happens; at all other times, no trade-off has to be made.

2. Consistent and Available: RDBMS (MySQL). If network is down, it will fail. Like for banking, you would want that to fail. Consistency - gives you absolute correctness, but expensive as the cost of storage goes up exponentially with cost due to more resources are needed to maintain consistency

3. Availability and Partition Tolerance: Cassandra, Dynamo. Give up consistency for speed and cost, so that my storage cost goes up linearly with quantity of data, as I don't need to worry about coordination and consistency. Should use this when we don't need 100% accuracy. Like online shopping or social network data

4. Consistency and Partition Tolerance: BigTable, Hbase, MongoDB. Not having guaranteed uptime

5. Concurrency: ensure correctness among operations that are executing simultaneously in a system

6. Latency:**time it takes for the selected sector** to be positioned under the read/write head



### Dynamo

1. When to use it?
   - Scalability, Avaiblility and Parition Tolerance: when we don't require absolute accuracy, when we care about latency and throughput, when we care about cost. High availability for writes
2. Read and Write:
   - Dyanmo's target: always writable. Don't miss a write because of unavailability of some node or network. Allow writes even if conflicted. Eg - shopping cart must always allows a customer to add or remove items
   - Resolve conflict at reads - use multiple copies to help achieve the conflict resolution - timestamp. Or merge carts with conflicting items.
3. Other Design Principles
   - Incremental scalability: one node added at a time. what is node about here? Easy to add - automatic, minimal impact to overall system
   - Node symmetry: every node is same as its peer. No distinguising node that takes special responsibilities. Easy to maintain and provision
   - Decentralized: no master machine
   - Heterogeniety: nodes can be heterogenous
   - Single administrative domain: no need for worrying about who has control. SQL has complex adminstrative process but dynamo abandons that
   - Fully trusted
   - Namespace is simple - usually is just one huge data, there's not so much metadata involved
   - Highly latency sensitive: how long does it take to have a transaction. How many reads/writes can we do in a second. We care about throughput
   - Every node needs to know every other node - n square problem again - how to solve this? I don't understand what he said in video
4. Partitioning algorithm - hashing function
   - consistent hashing. MD5 - message digest 5 - incremental scalability
5. Conflict resolving - high availability for writes, vector clock with recounciliation at reads
6. Advantage of virtual nodes: If a node becomes unavailable, load gets distributed over the ring and hence to several storage nodes. When a new node becomes available, Reverse – sheds load from multiple nodes
7. Replication: each data is replicated to N nodes - multiple virtual nodes
8. Versioning and vector clocks: each version of an object is associated with one vector clock. For an object then, we have its node location and the clock counter value. If the counters on the first object's clock are less than or equal to all of the nodes in the second clock, then the first is an ancestor of the second and can be forgotten, otherwise reconcile



## Lecture 4 - Cassandra

1. A better Dynamo. Based on Table-based BigTable and Indexed by key Dynamo. Key-value store
2. User: facebook, twitter, ebay
3. When to use:
   - Lots of data and many incoming requests resulting in a lot random reads and random writes
   - When you need highly available service with no single point of failure. Designed to run on cheap commodity hardware and handle write throughput while not sacrificing read efficiency
4. Pros: high availability (replication), incremental scalability (partitioning through consistent hashing), keep latency down through replication, eventual consistency is good enough,  knobs to tune tradeoffs between consistency, durability and latency. Minimal administration, low total cost of ownership
5. One big difference from dynamo: Internally resolves the conflict - go through the timestamps to check the correctness or gives probabiity that the result to be correct. Instead of letting programmer do it. 
6. Data Model
   - Table-based(as in Big Table)
   - Indexed by key (as in Dynamo)
   - Dynamo treats objects as blobs (binary large object). Cassandra data has structure but uses hash-ring key node structure to store the rows in the table
7. Hashing - take a number, hash it and decide which node the data will go into processing



## Lecture 5 - Google File Systems

Distributed file system for horizontal scaling. distributing blocks to different machines





## Lecture 6 - Hadoop

1. Intro:

   - An open-source reimplementation of google's map/reduce algorithm. A distributed filesystem and a runtime for implementing map/reduce algorithms

2. Hadoop Distributed Filesystem - an open source implementation based on google file system paper. Lousy for random IO but good for sequential IO. Slow writes, sequential writes only but amazing speed of sequential read

3.  Using HDFS

   - ```bash
     hdfs dfs (fs) -ls #fs is optional
     hdfs dfs -put localfile hdfsfile
     hdfs dfs -get hdfsfile localfile
     hdfs dfs -mkdir hdfsDirName
     hdfs dfs #no argument prints help
     ```

     ```bash
     #move a file from local to hdfs
     hdfs dfs -copyFromLocal /usr/share/dict/words sampledir/words
     
     hadoop jar /home/els69/hadoop-2.8.5/share/hadoop/tools/lib/hadoop-
     streaming-2.8.5.jar -input enrollment.txt -output classresults -
     mapper /shared/els69/mapper.py -reducer /shared/els69/reducer.py
     ```

4. HDFS Performance

   - Distribution across the network is used to increase the chances that a MAP function will run on the same node that the data node for its block is on --> increase the odds of moving computation to the data(fast), instead of moving data to the computation(slow)

5. Map/(shuffle)/Reduce

   - First do some transformation on every item to process. Apply a function to every element in a collection
   - Shuffle returns all results to one row
   - Then collapse all those results into useful, smaller aggregates

6. Hadoop Streaming:

   - Hadoop is written in JAVA. Sort and shuffle will follow alphabetical order

   - ```python
     #Q1
     #Mapper
     #!/usr/bin/python36
     
     import sys
     
     for binaryline in sys.stdin.buffer:
        line=binaryline.decode('latin-1')
        line=line.strip().split('|')
        key=line[0]
        if key:
           print(key,'\t',1)
         
      #Reducer
      #!/usr/bin/python
     
     import sys
     
     sum_val=0
     
     for line in sys.stdin:
        inputfields=line.split('\t')
        key=inputfields[0]
        val=inputfields[1]
        sum_val=sum_val+int(val)
       
     
     print('number of emergencies:'+str(sum_val))
     
     #Q2
     #Mapper
     #!/usr/bin/python36
     
     import sys
     
     for binaryline in sys.stdin.buffer:
        line=binaryline.decode('latin-1')
        line=line.strip().split("|")
        key=line[4]
        if key:
           print(key,"\t",1)
         
     #Reducer
     #!/usr/bin/python36
     
     import sys
     
     last_key=None
     sum_val=0
     
     
     for line in sys.stdin:
        inputfields=line.split('\t')
        key=inputfields[0]
        value=inputfields[1]
        if last_key and key!=last_key:
           print(last_key,'\t',sum_val)
           last_key=key
           sum_val=int(value)
        else:
           last_key=key
           sum_val=sum_val+int(value)
     
     if last_key:
           print(last_key,'\t',sum_val)
     
     
     #Q3
     #Mapper
     #!/usr/bin/python36
     
     import sys
     
     for binaryline in sys.stdin.buffer:
        line=binaryline.decode('latin-1')
        line=line.strip().split('|')
        key=line[7].split(':')[0]
        if key:
            print(key,'\t',1)
     
      #Reducer
     #!/usr/bin/python36
     
     import sys
     
     last_key=None
     sum_val=0
     
     for line in sys.stdin:
        inputfields=line.strip().split('\t')
        key=inputfields[0]
        value=inputfields[1]
        if last_key and last_key != key:
           print(last_key,'\t', sum_val)
           last_key=key
           sum_val=int(value)
        else:
           sum_val=sum_val+int(value)
           last_key=key
     
     print(last_key,'\t', sum_val)
     
     
     #Q4
     #!/usr/bin/python36
     
     import sys
     
     for binaryline in sys.stdin.buffer:
        line=binaryline.decode('latin-1')
        line=line.strip().split('|')
        county=line[4]
        hour=line[7].split(':')[0]
        key=county+','+hour
        if key:
           print(key,'\t',1)
         
     #!/usr/bin/python36
     
     import sys
     
     last_key=None
     sum_val=0
     
     for line in sys.stdin:
        inputfields=line.strip().split('\t')
        key=inputfields[0]
        val=inputfields[1]
        if last_key and last_key!=key:
           print(last_key, '\t', sum_val)
           last_key=key
           sum_val=int(val)
        else:
           last_key=key
           sum_val=int(val)+sum_val
     
     if last_key:
        print(last_key, '\t', sum_val)
     
     
     #Q5
     #!/usr/bin/python
     
     import sys
     count=0
     
     # Key = hour, value = 1
     for line in sys.stdin:
        if count==0:
     	count=count+1
     	continue
        else:
             time = line.strip().split("|")[7]
             key = time.split(":")[0]
             if key:
                print key, "\t", "1"
             
     #!/usr/bin/python
     
     import sys
     
     hours = dict()
     
     for binaryline in sys.stdin.buffer:
        line=binaryline.decode("latin-1")
        inputFields = line.split('\t')
        key = inputFields[0]
        val = inputFields[1]
     
        if key and int(key) in hours.keys():
            hours[int(key)] = hours[int(key)] + int(val)
            pass
        elif key:
            hours[int(key)] = int(val)
            pass
     
     
     for i in range(2,26):
        interval = str((i-2+24)%24) + '-' + str((i+24)%24)
        sum_total = hours[(i-2+24)%24] + hours[(i-1+24)%24] + hours[(i+24)%24]
        print(interval, '\t', sum_total)
        pass
     
         
     ```



     - has to write python36 if you want to use print(). Include binaryline for convenience and double check
     - remember to convert value to integer
     - In fact, all questions can be done using dictionary, but dict needs additional loop to print
     - In python 36, '\t' and "\t" don't differ

     ## Lecture 7 Hbase

     1. Column stored
        - row is great for relational database because we care about tuple
        - 1 million columns pretty comfortably
        - ❓(why relational data is not good for this) for sparse data: row is node, column is different data, key 1 has a vlue, key 40 won't have a value. For sparse data, it stores efficiently. What is sparse data? sensors
        - ❓(why relational data is not good) easier for aggregation function. adding things by column is very fast
        - handling missing value well



## Lecture 8 Office Hour

### Strengths and Weaknesses of Each DB

1. Cassandra

   - Strength:
     - Handle data with high write rate
     - High availability
   - Weakness:
     - Not good at range query
     - Not good at complex query

2. Neo4J

   - Strength:
     - Graphical data

3. Hadoop

   - Strength:
     - Handle complex query for unlimited rows
     - Amazing read capability
   - Weakness:
     - Very slow write. Not efficient for often for update and insert
     - Not good if calculation of data which has dependency on other data. For example, calculation compares 2 rows as we don't know where the partitioning point is. Hadoop assumes all data to be independent
     - Not good for simple query such as first 2 rows of a table

4. Hive

   - Strength:
     - Use SQL language and relational algebra. Good for project when you have old SQL code that is not scaling well. Can use join 
   - Weakness:
     - Not good for complex query and transformation
     - Not good for image processing

5. Hbase

   - Introduction: implementation of bigtable, column-stored database

   - Strength:

     - High consistency (may not follow exact order of operations. E.g bank will deduct highest spend first then small spend but not following the time you spend)
     - Rich programming environment, can use map reduce framework to implement complex computation more than average and sum
     - High rates of small operation time and low latency - 500 times per second
     - Good at range indexing
     - Column valued so Easy to do aggregation, compression, good for sparse and occasional data
     - Time stamping allows time travel

   - Weakness:

     - Slower for writes comparing with cassandra




