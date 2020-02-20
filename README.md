# SoalShiftSISOP20_modul1_B4
## 1. Membuat Laporan dari “Sample-Superstore.tsv”.

```bash
#!/bin/bash

meow=$(awk -F $'\t' 'NR>1{arr[$13]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -1 | awk -F ',' '{print $2}' )
echo -e "a.Bagian (Region) yang memiliki profit paling sedikit : $meow\n"

mybro=($(awk -F $'\t' -v x=$meow 'NR>1{if ($13 == x) arr[$11]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -2 | awk -F ',' '{print $2}'))

echo -e "b.2 Negara Bagian (State) yang memiliki \nprofit paling sedikit di Region $meow : \n${mybro[0]} dan ${mybro[1]}\n"

echo -e "c.List 10 produk yang memiliki profit paling sedikit pada state\n${mybro[0]} dan ${mybro[1]} di Region $meow :"
awk -F $'\t' -v x=$meow -v y=${mybro[0]} -v z=${mybro[1]} 'NR>1{if ( $13 == x && ( $11 == y || $11 == z)) arr[$17]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -10 | awk -F ',' '{print $2}'
```

### Penjelasan
  a. Memanggil awk dengan separator tab dan data yang dilihat dimulai dari row 2 dengan pengelompokan per Region yang disimpan diarray arr. Mengeprint jumlah profit dari setiap Region beserta regionnya kembali untuk disort dari yang terrendah dan diambil hasil paling atasnya. Lalu memanggil awk kembali untuk menyimpan nama regionnya saja yang memiliki profit paling kecil pada variabel meow
  
  b. Memanggil awk dengan separator tab dan data yang dilihat dimulai dari row 2 dan hanya memiliki Region yang diperoleh dari pekerjaan "a" dengan pengelompokan per State yang disimpan diarray arr. Mengeprint jumlah profit dari setiap state beserta statenya kembali untuk disort dari yang terrendah dan diambil hasil kedua paling atasnya. Lalu memanggil awk kembali untuk menyimpan nama statenya saja yang memiliki profit paling kecil pertama dan kedua pada array mybro
  
  c.Memanggil awk dengan separator tab dan data yang dilihat dimulai dari row 2 dan hanya memiliki Region yang diperoleh dari pekerjaan "a" dan hanya memiliki state yang diperoleh dari pekerjaan "b" dengan pengelompokan per Product Line yang disimpan diarray arr. Mengeprint jumlah profit dari setiap Product Line beserta statenya kembali untuk disort dari yang terrendah dan diambil hasil sepuluh paling atas. Lalu memanggil awk kembali untuk mengeprint nama Product Linenya saja yang memiliki profit paling kecil pertama hingga kesepuluh
  
* -v digunakan untuk memberi awk akses ke variabel yang meow dan mybro[] yang dialokasikan ke variabel x,y, dan z
* saat dilakukan awk kedua menggunakan separator koma sesuai dengan print dari awk pertama
* LC_ALL=C digunakan agar sorting byte-wise dan nilai xxx.yy(ratusan koma) tidak dibaca sebagai xxxyy(puluhan ribuan)


## 2. Pengamanan Kode Random dengan Enkripsi Cipher

```bash
#!/bin/bash
randompswd=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 ; echo '')
echo "kode unik tercipta : $randompswd"

NamaFileAwal=${1%.*}

if [[ $NamaFileAwal =~ [0-9] ]]
  then
    NamaFileAwal=${NamaFileAwal//[[:digit:]]/}
  fi

echo $randompswd>$NamaFileAwal.txt
echo "file tercipta : $NamaFileAwal.txt"
```

### Penjelasan
  a.Menggunakan "head /dev/urandom | tr -dc A-Za-z0-9 | head -c 28" untuk menggenerate kode unik yang terdapat alphabetical baik lower maupun upper case beserta angka dengan panjang 28 letter count. Memberikan display berupa kode unik yang tercipta pada user
  
  b. Membaca argumen pertama (nama_file) tanpa format file dibelakangnya, lalu membuang setiap angka yang ada terdapat pada nama_file. Lalu menyimpan kode unik yang diciptakan pada pekerjaan "a" pada nama_file.txt. Memberikan display nama file yang tercipta
  
```bash
#!/bin/bash

NamaFileAwal=${1%.*}

if [[ $NamaFileAwal =~ [0-9] ]]
  then
    NamaFileAwal=${NamaFileAwal//[[:digit:]]/}
  fi

jam=$(date -r $NamaFileAwal.txt +"%H")

hurufG=({A..Z})
hurufk=({a..z})

hurufGawal=${hurufG[ $(($jam % 26)) ]}
hurufGakhir=${hurufG[ $(( $(( $jam + 25 )) % 26 ))]}
hurufkawal=${hurufk[($jam%26)]}
hurufkakhir=${hurufk[(25+$jam)%26]}

NamaFileAkhir=$(echo "$NamaFileAwal" | tr [A-Za-z] ["$hurufGawal"-ZA-"$hurufGakhir""$hurufkawal"-za-"$hurufkakhir"])
# echo "$NamaFileAwal" | tr '[A-Za-z]' '["$hurufGawal"-ZA-"$hurufGakhir""$hurufkawal"-za-"$hurufkakhir"]'

mv $NamaFileAwal.txt $NamaFileAkhir.txt
echo "file terenkripsi menjadi : $NamaFileAkhir.txt"
```

  c. Melakukan pengecekan argumen kembali seperti pekerjaan "b". Lalu menyimpan jam file tersebut dibuat pada variabel jam. Menyimpan alfabet uppercase dan lowercase pada array yang berbeda lalu melakukan operasi penambahan jam pada huruf acuan awal dan akhir yang akan digunakan pada caesar cipher. Menggunakan caesar cipher dengan acuan yang sudah ditentukan untuk huruf uppercase dan lowercase lalu menyimpannya pada variabel NamaFileAkhir. Merename nama_file menjadi NamaFileAKhir.txt dan menampilkan nama file setelah dienkripsi
  
```bash
#!/bin/bash

NamaCrypted=${1%.*}

jam=$(date -r $1 +"%H")

hurufG=({A..Z})
hurufk=({a..z})

hurufGawal=${hurufG[ $(($jam % 26)) ]}
hurufGakhir=${hurufG[ $(( $(( $jam + 25 )) % 26 ))]}
hurufkawal=${hurufk[($jam%26)]}
hurufkakhir=${hurufk[(25+$jam)%26]}


NamaDecrypted=$(echo "$NamaCrypted" | tr ["$hurufGawal"-ZA-"$hurufGakhir""$hurufkawal"-za-"$hurufkakhir"] [A-Za-z])
# echo "$NamaCrypted" | tr '[A-Za-z]' '["$hurufGawal"-ZA-"$hurufGakhir""$hurufkawal"-za-"$hurufkakhir"]'

mv $NamaCrypted.txt $NamaDecrypted.txt
echo "file terdekripsi menjadi : $NamaDecrypted.txt"
```

  d. Membaca argumen pertama (nama_file) tanpa format file dibelakangnya lalu disimpan pada variabel NamaCrypted. Lalu menyimpan jam file tersebut dibuat pada variabel jam. Menyimpan alfabet uppercase dan lowercase pada array yang berbeda lalu melakukan operasi penambahan jam pada huruf acuan awal dan akhir yang akan digunakan pada caesar cipher. Menggunakan caesar cipher dengan format `tr x y` yang dibalik menjadi `tr y x`. Merename nama file yang terenkripsi menjadi NameDecrypted.txt dan menampilkan nama file setelah didekripsi
