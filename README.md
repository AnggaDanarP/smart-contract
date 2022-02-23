# TEST 1
Jadi sintaks ini `(bool sent, ) = msg.sender.call{value: _amount}("");` pada funsi `withdraw()` secara otomatis akan mentrigger fungsi `callback()` pada attacker sehingga akan memanggil kembali fungsi `withdraw()` lagi. Pada fungsi `withdraw()` akan dilakukan pengecekan dan melakukan UPDATE pada balance sebelum mentransfer ether[ `balances[msg.sender] -= _amount;` ]. Yang pada akhirnya `require(_amount <= balances[msg.sender]);` akan menganggap `false` dan secara otomatis sistem akan memberhentikan looping `callbac()` dari attacker.

Cara kedua dengan menambahkan modifier yang bertujuan untuk melakukan `locked` pada sebuah fungsi dimana hanya dapat melakukan satu kali pengeksekusian pada fungsi `withdraw()`. Jadi saat fungsi di eksekusi, `bool locked internal` akan di set menjadi `true`, kemudian mengeksekusi fungsi `withdraw`. Saat attacker menggunakan fungsi `calback()` untuk memanggil fungsi `withdraw()` kedua kalinya sebelum eksekusi pertamanya selesai, modifier akan dipanggil lagi dimana varibale `locked` adlah `true` yang membuat pemanggilan kedua menjadi gagal dengan bantuan sintaks `require(!locked, "No reentrancy allowed");` pada modifier.
# TEST 2
Smart contract untuk menggabungkan string dan string, string dengan uint, dan menggabungkan kumpulan data struct menjadi satu.
# TEST 3
ini adalah simple smart contract dimana terdapat fungsi untuk registrasi, pengecekan status sudah terdaftar atau belum, dan yang terakhir adalah fungsi leave untuk menghapus data dari smart contract

Fungsi registrasi akan mengecek berdasarkan address wallet user apakah address tersebut sudah terdaftar atau belum. jika belum maka user dapat melakukan registrasi dan data yang dibutuhkan berupa nama, email dan password

untuk mendapatkan statusmya, akan dilakukan pengecekan pada mapping dengan berpatokan pada address wallet user. Jika wallet masih kosong maka sistem akan menampilkan output `Your account is not Registered` begitupun sebaliknya apabila address wallet user sudah terdaftar maka sistem akan mengoutputkan `Your account is Registered`

fungsi leave bertujuan untuk menghapus data user dari smart contract. yaitu mengubah nilai mapping pada parameter walletAddress menjadi kosong. Dengan begitu sistem akan tetap menganggap bahwa user tersebut sudah menghapus dan keluar dari sistem.
Sesuai dengan dokumentasi solidity delete disini tidak sepenuhnya menghapus data, melainkan mengubah nilai dari varibale menjadi `default`
https://solidity.readthedocs.io/en/v0.4.24/types.html#delete
# TEST 4
Solidity simple ERC20 token contract

`totalSupply` adalah total jumlah amount dari token ERC20

`balanceOf` adalah mnedapatkan total token ERC20 berdasarkan parameter address sebagai input

fungsi `transfer` berfungsi sebagai pengiriman token ER20 secara langsung berdasarkan parameter address tujuan dan besar amount yang ingin di kirimkan

`transferForm` hampir sama dengan fungsi transfer, bedanya adalah terdapat parameter tambahan yaitu address dari pengirim token. Sehingga pengirim lebih dispesifikasikan.

kedua fungsi pengiriman token tersebut akan dilakukan fungsi tambahan berupa fungsi `approve` dimana setiap transaksi yang dilakukan akan melewati persetujuan terlebih dahulu

dan seberapa banyak spender mengirimkan tokennya dapat menggunakan fungsi `allow`
# TEST 5
fungsi `getMessageHash()` bertujuan untuk sign dan melakukan hashing pada pesan yang diinputkan oleh user menggunakan algoritma hash keccak256.

Fungsi `getEthSignedMessageHash()` membutuhkan signatur yang dihasilkan dengan melakukan signing keccak256 menggunakan format berikut. `"\x19Ethereum Signed Message\n" + len(msg) + msg`. panjang dari message adalah 32 karena hasil dari hash keccak256 itu sendiri terdiri dari `32 bytes`.

Kedua fungsi di atas adalah fungsi yang kita gunakan dalam memproses pesan yang sudah di hash. Setelah itu fungsi `verify()` bertujuan untuk melakukan pengecekan hasil perbandingan `getMessageHash()` dengan `getEthSignedMessageHash()` apakah sama.

fungsi `recoverSigner()` memanggil fungsi build-in `ecrecover` yang mempunyai parameter hasil dari fungsi `getEthSignedMessageHash()` beserta parameter `r`, `s`, `v` yang dilakukan split.

fungsi `splitSignature()` bertujuan untuk melakukan pemecahan `byte signature` yang membunyai panjang `96 bytes`. Kode program akan melakukan skip pada `32 bytes` pertama dan dimasukan kedalam variable `r`. Untuk mendapatkan variable `s` akan dilakukan hal yang sama dengan skip dari `32 bytes` sampai dengan `64 bytes` panjang dari signature. Untuk mendapatkan variable `v` dilakukan skip `96 bytes`.

