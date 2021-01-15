# Securitify :copyright:



This project is a demonstration of some security aspects using Flutter Framework.

* Coding/Decoding
* Hashing / Hash cracking
* Symmetric encryption/decryption
* Asymmetric encryption/decryption

Also for fun we implemented A **Chatroom App** &  **Messenger chat app** inside the main app in order to demonstrate how Symmetric and Asymmetric encyption works.

## Architecture

The project is composed of two parts.

* **The Server**: NodeJs App hosted on heroku that will play the role of the **bridge** between client and our  **Keyserver**.
  * Project Repo:  [securityProjectServer](https://github.com/achreffaidi/securityProjectServer)
* **The Client App**: A Flutter mobile app that contains all our buisness logic.

## Demonstration

Now the fun part 😎, Let's discover the app.

### Configuration

By clicking the ⚙️ icon on the top of the screen this screen will open up.

![](https://via.placeholder.com/300)

From here you can setup the username that will be used later on the chat app.



### Coding / Decoding

By clicking the Coding/decoding button on the Main screen you will get this interface:

![](https://via.placeholder.com/300)

#### Encoding:



![](https://via.placeholder.com/300)

Encoding support 3 coding algorithm:

* To Base64
* To Binary
* To Ascii

To illustrate, this is the output of running encoding `Hello world` in :

* Base64: `aGVsbG8gd29ybGQ=`
* Binary: `1101000 1100101 1101100 1101100 1101111 100000 1110111 1101111 1110010 1101100 1100100`
* Ascii: `104 101 108 108 111 032 119 111 114 108 100`



#### Decoding

![](https://via.placeholder.com/300)

Nothing special, It just reverse the operation of encoding.



### Hashing

In this part you'll see how we can hash text and crack the hashing using a **brute-force attack** .

#### Hashing:

![](https://via.placeholder.com/300)

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

Device : Xiomi Note 7

* Qualcomm SDM660 Snapdragon 660 (14 nm)
* 8gb RAM

Test on the 5 milions words : 62.85 minutes

Test per second : 1325 test/s



### Symmetric encryption

This is the screen you'll see when you open go to symmetric from the main screen.

![](https://via.placeholder.com/300)

#### Encrypt

![](https://via.placeholder.com/300)

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

![](https://via.placeholder.com/300)

Nothing special about it, It just reverse the operation of encryption using the same **key**.

### ChatRoom

To enter a chatroom the user should specify the **roomName** and the **key** used for symmetric encryption.

Without the key, the user won't be able to see other people messages.

More than 2 persons can join the room. Actually anyone with the **key** can.

You can see in the screen the cool UI of the Chatroom.

![](https://via.placeholder.com/300)



By Clicking any chat item you will be rediracted to a page with all the details about that message including :

* The  Symmetric Encryption **Algorithm**
* The **key**
* The **Encrypted Message** that is transmitted through internet.
* The **Decrypted message** that was decrypted locally in your device using the **key** .

![](https://via.placeholder.com/300)

We don't spy on your messages, we are not  **WhatsApp** :sob:  , be like us :sunglasses: .





