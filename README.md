# Crypto :copyright:

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/logo.png?raw=true" style="zoom:15%;" />

#### Authors:

* [Achraf Feydi](https://www.linkedin.com/in/achraf-feydi-18762815a/)
* [Mohamed Saïd Fayache](https://www.linkedin.com/in/mohamed-said-fayache/)



This project is a demonstration of some cryptography algorithms using Flutter Framework including:

* Coding/Decoding.
* Hashing / Hash cracking.
* Symmetric encryption/decryption.
* Asymmetric encryption/decryption.

Also for fun, we implemented A **Chatroom App** &  **Messenger chat app** inside the main app in order to demonstrate how Symmetric and Asymmetric encyption works .

The message exchange will is performed through **Sockets**.

## Architecture

The project is composed of two parts.

* **The Server**: NodeJs App **hosted on heroku** that will play the role of the **bridge** between client and our  **Keyserver**.
  * Project Repo:  [securityProjectServer](https://github.com/achreffaidi/securityProjectServer)
* **The Client App**: A Flutter mobile app that contains all our buisness logic.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/sec.png?raw=true" style="zoom: 67%;" />

------



## Demonstration

> “A user interface is like a joke. If you have to explain it, it’s not that good”. — Martin Leblanc

Our User Interface is super **userfriendly**, but for educational purposes :man_student:  we will explain it.

Now the fun part 😎, Let's discover the app.

### Main Screen

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457120.jpg?raw=true" style="zoom: 25%;" />

### Configuration

By clicking the ⚙️ icon on the top of the screen this screen will open up.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457112.jpg?raw=true" style="zoom:25%;" />

From here you can setup the username that will be used as the identifier of our user.



------



### Coding / Decoding

By clicking the `Encoding` button on the Main screen you will get this interface:

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457104.jpg?raw=true" style="zoom:25%;" />

#### Encoding:



<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457087.jpg?raw=true" style="zoom:25%;" />

Encoding support 3 coding algorithm:

* To Base64
* To Binary
* To Ascii

To illustrate, this is the output of running encoding `Hello world` in :

* Base64: `aGVsbG8gd29ybGQ=`
* Binary: `1101000 1100101 1101100 1101100 1101111 100000 1110111 1101111 1110010 1101100 1100100`
* Ascii: `104 101 108 108 111 032 119 111 114 108 100`



#### Decoding

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457079.jpg?raw=true" style="zoom:25%;" />

Nothing special, It just reverse the operation of encoding.



------



### Hashing

In this part you'll see how we can hash text and crack the hashing using a **brute-force attack** .

#### Hashing:

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457062.jpg?raw=true" style="zoom:25%;" />

You can choose of the following Algorithms for hashing:

* SHA-1
* SHA-224
* SHA-256
* SHA-384
* SHA-512
* MD5

To illustrate, this is the output of running hashing `Hello world` in :

* SHA-1 : `2aae6c35c94fcfb415dbe95f408b9ce91ee846ed`
* SHA-224 : `2f05477fc24bb4faefd86517156dafdecec45b8ad3cf2522a563582b`
* SHA-256 : `b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9`
* SHA-384 : `fdbd8e75a67f29f701a4e040385e2e23986303ea10239211af907fcbb83578b3e417cb71ce646efd0819dd8c088de1bd`
* SHA-512 : `309ecc489c12d6eb4cc40f50c902f2b4d0ed77ee511a7c7a9bcd3ca86d4cd86f989dd35bc5ff499670da34255b45b0cfd830e81f605dcf7dc5542e93ae9cd76f`
* MD5 : `5eb63bbbe01eeed093cb22bb8f5acdc3`

#### Cracking the Hash

For the **brute-force attack** we are using a **5 Milions word** dictionary downloaded from  [this link](https://thehacktoday.com/password-cracking-dictionarys-download-for-free/) .

Because of the huge computational power required for this operation we had to divide the dictionary **mini-batchs** with 10000 words in each of them.

Also we executed the code using the `compute` function to do all the work on a different "Thread" to avoid skipping frames and give a feed back on the operation's progress since it takes a long time.

##### Test result :

Device : Xiaomi Note 7

* Qualcomm SDM660 Snapdragon 660 (14 nm)
* 8gb RAM

Test on the 5 milions words : 59.8525 minutes

Tests per second : 1392 test/s



------



### Symmetric encryption

This is the screen you'll see when you open go to `Symmetric Encryption` from the main screen.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457046.jpg?raw=true" style="zoom:25%;" />

#### Encrypt

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457038.jpg?raw=true" style="zoom:25%;" />

For symmetric encryption we need, in addition to the text, a **key** that both side of the encrypted communication knows.

Any one with the **key** can encrypt and decrypt messages.

You can choose of the following Algorithms for Encryption:

* AES CBC
* AES CFB-64
* AES CTR
* AES ECB
* AES OFB-64/GCTR
* AES OFB-64
* AES SIC

To illustrate, this is the output of running encryption `Hello world` using `VincentRijmen` as the Key :

* AES CBC : `eLVXrWTx1oBdRqy9PAbcAw==`
* AES CFB-64 : `lWc7T08TGmJzU3nP6hS8nQ==`
* AES CTR : `lWc7T08TGmLYvH25MZR7IQ==`
* AES ECB : `eLVXrWTx1oBdRqy9PAbcAw==`
* AES OFB-64/GCTR : `GGkCZJK5inYtcyzxpCVEug==`
* AES OFB-64 : `lWc7T08TGmL8Y1Ip3KiWEg==`
* AES SIC : `lWc7T08TGmLYvH25MZR7IQ==`

#### Decryption

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457030.jpg?raw=true" style="zoom:25%;" />

Nothing special about it, It just reverse the operation of encryption using the same **key**.



### ChatRoom :house:

>  The Server is hosted online, you can download and try the app with your friends :man_technologist:

To enter a chatroom the user should specify the **roomName** and the **key** used for symmetric encryption.

Without the key, the user won't be able to see other people messages.

More than 2 persons can join the room. Actually anyone with the **key** can.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457014.jpg?raw=true" style="zoom:25%;" />

You can see in the screen the cool UI of the Chatroom.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456914.jpg?raw=true" style="zoom:25%;" />



By Clicking any chat item you will be redirected to a page with all the details about that message including :

* The  Symmetric Encryption **Algorithm**
* The **key**
* The **Encrypted Message** that is transmitted through internet.
* The **Decrypted message** that was decrypted locally in your device using the **key** .

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456904.jpg?raw=true" style="zoom:25%;" />

We don't spy on your messages, we are not  **WhatsApp** :sob:  , be like us :sunglasses: .



------



### Asymmetric encryption

This is the screen you'll see when you click `Asymmetric encryption` on the main screen.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829457006.jpg?raw=true" style="zoom:25%;" />

#### Key Manager

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456998.jpg?raw=true" style="zoom:25%;" />

The key manager allow the user to **generate key pairs** (public key, private key) and upload the public key to the **keyServer**.

* Algorithm: `RSA`
* Key size: `2048 bit`

#### Encrypt

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456990.jpg?raw=true" style="zoom:25%;" />

This Interface allows the user to encrypt a message using a **public key**.

* Algorithm: RSA
* Hash: SHA256
* Padding scheme: [OAEP](https://en.wikipedia.org/wiki/Optimal_asymmetric_encryption_padding) (Optimal asymmetric encryption padding)

#### Decrypt

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456982.jpg?raw=true" style="zoom:25%;" />

This Interface allows the user to encrypt a message using a **private key**.

#### Sign

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456974.jpg?raw=true" style="zoom:25%;" />

This Interface allows the user to sign a message using a **private key**.

* Algorithm: RSA
* Hash: SHA256
* Encoding methods: [PSS](https://web.archive.org/web/20040713140300/http://grouper.ieee.org/groups/1363/P1363a/contributions/pss-submission.pdf) (Provably Secure Encoding Method for Digital Signatures)

#### Verify Signature

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456965.jpg?raw=true" style="zoom:25%;" />

This Interface allows the user to encrypt a message using the combination of  **public key** + message.



#### Messenger :love_letter:

> The Server is hosted online, you can download and try the app with your friends :man_technologist:

Now to the **coolest** part.

First, let's understand how things work then we will see the UI.

Let's say `Bob` want to send a message to `Alice` , this is what going to happen:

1. `Bob` download `Alice`'s **public key** from our KeyServer.
2. `Bob` encrypts the message using `Alice` **public key**.
3. `Bob` signs the message using his **private key**
4. `Bob` send the signature and encrypted message to `Alice`
5. `Alice` download `Bob`'s **public key** from our keyServer.
6. `Alice` decrypt the message using her **private key**.
7. `Alice` verify `Bob`'s signature using his **public key**.

##### Problems we had :warning:  :

Life is not always a bed of roses, we learned it the hard way that RSA actually has a maximum size of message to encrypt.

To calculate it we can use this [table](app.zeplin.io/project/5fd771dbb3cb289a179cc326):

| Hash    | OVERHEAD | RSA 1024 | RSA 2048 | RSA 3072 | RSA 4096 |
| ------- | -------- | -------- | -------- | -------- | -------- |
| SHA-1   | 42       | 86       | 214      | 342      | 470      |
| SHA-224 | 58       | 70       | 198      | 326      | 454      |
| SHA-256 | 66       | 62       | 190      | 318      | 446      |
| SHA-384 | 98       | 30       | 158      | 286      | 414      |
| SHA-512 | 130      | N/A      | 126      | 254      | 382      |

Since we are using **RSA 2048** with **SHA-256** then we only have 190 bytes as maximum size.

And if we take in concediration that **OAEP** padding takes 42 bytes, then the remaining is `148 bytes` :thinking:.

To solve the issue we had to make our message's size a multiple of `148` by adding extra spaces on the top right. then we divide the message in blocks of `148 bytes`, encrypt each of them and send the concatinated result. :sunglasses:

We also send the **size of an encrypted block** so the receiver can reverse the operation and get the message back.

This is an example of a transmetter message:

```json
{
    "receiverChatID": "Achraf",
    "senderChatID": "Said",
    "content": {
        "message": "LP1hplB9IczCgoWBYu3yWCP9K7+uZF3RM0iKwSU6L33SVfS1eMDqW6WYWnQs5SdCsiFLriOIQU0y8pgouUlrODIR32SGSmgQwMaZJLbHCUvRMub3kBnmTb7iygdtHq6kzEWBydAsZ4iIjQ8jdg3MeJk/pHLaeDRJzM/dv8eg+QXZgcQbsJRk5KfFtnwMkvyzq1lYZA5Q2f+8rsfnbCzJ4OEsqfXPpsB/MXwrf3m1sxvuM/TeXZvPVeLvJ546pcnKKusDYRoqiGlEM/pfmB2ESle+VC6VyMXCk603JSwhTSPXZehVqFnGgNWLnJ20K+VTtV212DGHRjE3jsrNImGsJw==",
        "blockSize":344,
 "signature":"SaQYhD+U6gXPz1Go+otOPiGRPkaiwQZuI4bcDEiuwTvVgivcbF6uE2v37oaI5tQC9HeusEIou0INGLSLxxO+J91gQ5tKuW3tiUi9L6JNwJ4UHb8j0Ucfjvdon41xqt2duVnq5p+/67SlvSKBOR/3CIOdFKMuF9XZhCkwsDfj+PkNBCBGfx1kpQTlLEFYWWmf2X8TeTvxn6Kch3tHORft5gVhpAxBCCPLEN2+5NWe9zJYqhiRJA28Sy15J2wiSpqKNn2MM2HY3biez38lt2fbnJGfaKJ0fz+NRoxI2czB2TBbQilZRtJ9bW0ngQSmp/DZMnHLy4Xjcq0X61qG/2p06g=="}
}
```

##### Messenger

By clicking the :heavy_plus_sign: button on the bottom of the screen, the user gets the list of users who published their public keys on the keyServer.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456957.jpg?raw=true" style="zoom:25%;" />



By clicking on a user name, our user will be redirected to the chat screen.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456949.jpg?raw=true" style="zoom:25%;" />

By clicking on a received message the user can see all the details of the communication process.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456941.jpg?raw=true" style="zoom:25%;" />

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456932.jpg?raw=true" style="zoom:25%;" />

And back to the messenger screen, the user can switch between different conversations.

<img src="https://github.com/achreffaidi/securityMobileApp/blob/master/Images/ReadmeImages/1610829456924.jpg?raw=true" style="zoom:25%;" />

We are not saving messages locally, so once the user leaves the app, all data will be removed from the RAM.
