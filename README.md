# TEST 1

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
