# Network Analysis

## Time Thieves

At least two users on the network have been wasting time on YouTube. Usually, IT wouldn't pay much mind to this behavior, but it seems these people have created their own web server on the corporate network. So far, Security knows the following about these time thieves:

- They have set up an Active Directory network.
- They are constantly watching videos on YouTube.
- Their IP addresses are somewhere in the range `10.6.12.0/24`.

You must inspect your traffic capture to answer the following questions in your Network Report:
1. What is the domain name of the users' custom site?
  - `Frank-n-Ted-DC.frank-n-ted.com`
  - **Filter:** `ip.addr==10.6.12.0/24`
  ![na_1](images/na_1.png)
2. What is the IP address of the Domain Controller (DC) of the AD network?
  - `10.6.12.12`
  - **Filter:** `ip.addr==10.6.12.0/24 && kerberos.CNameString`
  ![na_2](images/na_2.png)
3. What is the name of the malware downloaded to the 10.6.12.203 machine?
  - Once you have found the file, export it to your Kali machine's desktop.
    - **Filter:** `ip.src==10.6.12.203 && http.request.method==GET`
    - **File:** `june11.dll`
    ![na_3](images/na_3.png)
4. Upload the file to [VirusTotal.com](https://www.virustotal.com/gui/). 
  ![na_4](images/na_4.png)
5. What kind of malware is this classified as?
  - The malware is most likely a Trojan
  ![na_5](images/na_5.png)

## Vulnerable Windows Machines

The Security team received reports of an infected Windows host on the network. They know the following:
- Machines in the network live in the range `172.16.4.0/24`.
- The domain mind-hammer.net is associated with the infected computer.
- The DC for this network lives at `172.16.4.4` and is named Mind-Hammer-DC.
- The network has standard gateway and broadcast addresses.

Inspect your traffic to answer the following questions in your network report:

1. Find the following information about the infected Windows machine:
    - Host name: `Rotterdam-PC`
    - IP address: `172.16.4.205`
    - MAC address: `00:59:07:b0:63:a4`
  - **Filter:** `ip.dst==172.16.4.0/24 && kerberos.CNameString`
  ![na_6](images/na_6.png)
    
2. What is the username of the Windows user whose computer is infected?
  - User: `matthijs.devries`
  ![na_7](images/na_7.png)
3. What are the IP addresses used in the actual infection traffic?
  - By looking at the top conversations with `172.16.4.205` we can see the following IPs were likely to be infection traffic: `185.243.115.84` `166.62.111.64`
    - **Filter:** `ip.addr==172.16.4.205`
    ![na_8](images/na_8.png)
4. As a bonus, retrieve the desktop background of the Windows host.
  ![na_9](images/na_9.png)

## Illegal Downloads

IT was informed that some users are torrenting on the network. The Security team does not forbid the use of torrents for legitimate purposes, such as downloading operating systems. However, they have a strict policy against copyright infringement.

IT shared the following about the torrent activity:

- The machines using torrents live in the range `10.0.0.0/24` and are clients of an AD domain.
- The DC of this domain lives at `10.0.0.2` and is named DogOfTheYear-DC.
- The DC is associated with the domain dogoftheyear.net.

Your task is to isolate torrent traffic and answer the following questions in your Network Report:

1. Find the following information about the machine with IP address `10.0.0.201`:
    - MAC address: `00:16:17:18:66:c8`
    - Windows username: `elmer.blanco`
    - OS version: `Windows 10`
  - **Filter:** `ip.src==10.0.0.201 && kerberos.CNameString`
  ![na_10](images/na_10.png)
  ![na_11](images/na_11.png)

2. Which torrent file did the user download?
  - **Filter:** `ip.src==10.0.0.201 && http.request.uri contains ".torrent"`
  ![na_12](images/na_12.png)
