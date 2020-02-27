# SoalShiftSISOP20_modul1_B02
## Kelompok B02
* 05111840000089 - Aulia Ihza Hendradi         - 
* 05111840000161 - Kinassihurrabb Moralluhung
* 05111840000162 - Fransiskus Xaverius Kevin Koesnadi
### 1. Membuat Laporan dari “Sample-Superstore.tsv”.

```bash
#!/bin/bash

#-----------------------------Soal a------------------------------
meow=$(awk -F $'\t' 'NR>1{arr[$13]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -1 | awk -F ',' '{print $2}' )
echo -e "a.Bagian (Region) yang memiliki profit paling sedikit : $meow\n"

#-----------------------------Soal b------------------------------
mybro=($(awk -F $'\t' -v x=$meow 'NR>1{if ($13 == x) arr[$11]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -2 | awk -F ',' '{print $2}'))

echo -e "b.2 Negara Bagian (State) yang memiliki \nprofit paling sedikit di Region $meow : \n${mybro[0]} dan ${mybro[1]}\n"

#-----------------------------Soal c------------------------------
echo -e "c.List 10 produk yang memiliki profit paling sedikit pada state\n${mybro[0]} dan ${mybro[1]} di Region $meow :"
awk -F $'\t' -v x=$meow -v y=${mybro[0]} -v z=${mybro[1]} 'NR>1{if ( $13 == x && ( $11 == y || $11 == z)) arr[$17]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -10 | awk -F ',' '{print $2}'
```
#### soal1.sh
* Cara menggunakan `bash soal1.sh ` dan pastikan file “Sample-Superstore.tsv” berada pada directory yang sama dengan script ini

#### Penjelasan
  a. Memanggil `awk` dengan separator tab dan data yang dilihat dimulai dari row 2 dengan pengelompokan per Region yang disimpan diarray arr. Mengeprint jumlah profit dari setiap Region beserta regionnya kembali untuk disort dari yang terrendah dan diambil hasil paling atasnya. Lalu memanggil `awk` kembali untuk menyimpan nama regionnya saja yang memiliki profit paling kecil pada variabel meow
  
  b. Memanggil `awk` dengan separator tab dan data yang dilihat dimulai dari row 2 dan hanya memiliki Region yang diperoleh dari pekerjaan "a" dengan pengelompokan per State yang disimpan diarray arr. Mengeprint jumlah profit dari setiap state beserta statenya kembali untuk disort dari yang terrendah dan diambil hasil kedua paling atasnya. Lalu memanggil `awk` kembali untuk menyimpan nama statenya saja yang memiliki profit paling kecil pertama dan kedua pada array `mybro`
  
  c.Memanggil `awk` dengan separator tab dan data yang dilihat dimulai dari row 2 dan hanya memiliki Region yang diperoleh dari pekerjaan "a" dan hanya memiliki state yang diperoleh dari pekerjaan "b" dengan pengelompokan per Product Line yang disimpan diarray arr. Mengeprint jumlah profit dari setiap Product Line beserta statenya kembali untuk disort dari yang terrendah dan diambil hasil sepuluh paling atas. Lalu memanggil `awk` kembali untuk mengeprint nama Product Linenya saja yang memiliki profit paling kecil pertama hingga kesepuluh

* `-F` digunakan untuk menentukan separator bila `'\t'` berarti separatornya adalah tab sedangkan jika `','` maka separatornya koma
* `NR>1` digunakan untuk mengabaikan baris pertama pada file yang diakses karna hanya berisi nama kolom
* `{arr[$13]+=$21}` digunakan untuk mengelompokkan setiap profit kedalam array arr dengan Region sebagai indeks
* `-v` digunakan untuk memberi awk akses ke variabel yang meow dan mybro[] yang dialokasikan ke variabel x,y, dan z
* saat dilakukan `awk` kedua menggunakan separator koma sesuai dengan print dari awk pertama
* `sort -n` digunakan agar sorting numerically dari bilangan terkecil
* `LC_ALL=C` digunakan agar sorting byte-wise dan nilai xxx.yy(ratusan koma) tidak dibaca sebagai xxxyy(puluhan ribuan)
* `head -x` digunakan agar hasil `awk` pertama ditampilkkan sebanyak nilai x dari result paling atas(paling kecil)


### 2. Pengamanan Kode Random dengan Enkripsi Cipher

```bash
#!/bin/bash
#-----------------------------Soal a------------------------------
randompswd1=$(head /dev/urandom | tr -dc A-Z | head -c 1 ; echo '')
randompswd2=$(head /dev/urandom | tr -dc a-z | head -c 1 ; echo '')
randompswd3=$(head /dev/urandom | tr -dc 0-9 | head -c 1 ; echo '')
randompswd4=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 25 ; echo '')


case "$((RANDOM % 6))" in
  "0")
  randompswd="$randompswd1$randompswd2$randompswd3$randompswd4"
  ;;
  "1")
  randompswd="$randompswd1$randompswd3$randompswd2$randompswd4"
  ;;
  "2")
  randompswd="$randompswd3$randompswd2$randompswd1$randompswd4"
  ;;
  "3")
  randompswd="$randompswd3$randompswd1$randompswd2$randompswd4"
  ;;
  "4")
  randompswd="$randompswd2$randompswd3$randompswd1$randompswd4"
  ;;
  "5")
  randompswd="$randompswd2$randompswd1$randompswd3$randompswd4"
  ;;
esac


echo "kode unik tercipta : $randompswd"

NamaFileAwal=${1%%.*}

#-----------------------------Soal b------------------------------
if [[ $NamaFileAwal =~ [0-9] ]]
  then
    NamaFileAwal=${NamaFileAwal//[[:digit:]]/}
  fi

echo $randompswd>$NamaFileAwal.txt
echo "file tercipta : $NamaFileAwal.txt"

#-----------------------------Soal c------------------------------
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
~                                                       
```
#### soal2.sh
* Cara menggunakan `bash soal2.sh "NamaFile".txt`
#### Penjelasan
  a.Menggunakan `head /dev/urandom | tr -dc A-Za-z0-9 | head -c 28` untuk menggenerate kode unik yang terdapat alphabetical baik lower maupun upper case beserta angka dengan panjang 28 letter count. Memberikan display berupa kode unik yang tercipta pada user. Kombinasi password yang dihasilkan memiliki kemungkinan tata letak antara huruf dan angka semisal `Ab0` maka kemungkinan yang dihasilkan akan memiliki kombinasi `Ab0`,`A0b`,`bA0`,`b0A`,`0Ab`,`0bA` sehingga terdapat 6 kemungkinan, maka perlu dituliskan syntax
  
  ```
  #!/bin/bash
randompswd1=$(head /dev/urandom | tr -dc A-Z | head -c 1 ; echo '')
randompswd2=$(head /dev/urandom | tr -dc a-z | head -c 1 ; echo '')
randompswd3=$(head /dev/urandom | tr -dc 0-9 | head -c 1 ; echo '')
randompswd4=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 25 ; echo '')


case "$((RANDOM % 6))" in
  "0")
  randompswd="$randompswd1$randompswd2$randompswd3$randompswd4"
  ;;
  "1")
  randompswd="$randompswd1$randompswd3$randompswd2$randompswd4"
  ;;
  "2")
  randompswd="$randompswd3$randompswd2$randompswd1$randompswd4"
  ;;
  "3")
  randompswd="$randompswd3$randompswd1$randompswd2$randompswd4"
  ;;
  "4")
  randompswd="$randompswd2$randompswd3$randompswd1$randompswd4"
  ;;
  "5")
  randompswd="$randompswd2$randompswd1$randompswd3$randompswd4"
  ;;
esac


echo "kode unik tercipta : $randompswd"

  ```
  * `randompswd1`, digunakan untuk men-generate huruf kapital A-Z
  * `randompswd2`, digunakan untuk men-generate huruf kecil a-z
  * `randompswd3`, digunakan untuk men-generate angka 0-9
  * `randompswd4`, digunakan sebagai tempat mengabungkan setiap karakter yang dihasilkan
  
  ```
  case "$((RANDOM % 6))" in
  "0")
  randompswd="$randompswd1$randompswd2$randompswd3$randompswd4"
  ;;
  "1")
  randompswd="$randompswd1$randompswd3$randompswd2$randompswd4"
  ;;
  "2")
  randompswd="$randompswd3$randompswd2$randompswd1$randompswd4"
  ;;
  "3")
  randompswd="$randompswd3$randompswd1$randompswd2$randompswd4"
  ;;
  "4")
  randompswd="$randompswd2$randompswd3$randompswd1$randompswd4"
  ;;
  "5")
  randompswd="$randompswd2$randompswd1$randompswd3$randompswd4"
  ;;
esac

  ```
  * `case "$((RANDOM % 6))" in` 
  generate password secara random dengan banyaknya 6 kemungkinan. Kemungkinan sebanyak enam didapatkan berdasarkan pada contoh yang telah disebutkan di atas.
  * `"0") randompswd="$randompswd1$randompswd2$randompswd3$randompswd4"`
  contoh kemungkinan pertama (iterasi ke-nol) tersusun secara berututan atas huruf kapital, huruf kecil, dan angka dalam `randompswd4` dan tersusun secara random. Hal ini akan berlaku pada iterasi berikutnya (sampai iterasi ke-5)
  
  b. Membaca argumen pertama (nama file) tanpa format file dibelakangnya yang disimpan pada variabel NamaFileAwal, lalu membuang setiap angka yang ada terdapat pada nama file dan mengalokasikannya kembali pada variabel NamaFileAwal. Lalu menyimpan kode unik yang diciptakan pada pekerjaan "a" pada nama_file.txt. Memberikan display nama file yang tercipta


* `${1%%.*}` digunakan untuk membuang format file dari argumen pertama (setelah ditemukan tanda titik `.`)
* `NamaFileAwal//[[:digit:]]/` digunakan untuk membuang setiap digit dari NamaFileAwal
* `$randompswd>$NamaFileAwal.txt` digunakan untuk menyimpan kode unik yang diciptakan pada nama file yang telah ditentukan


```bash
#!/bin/bash

NamaFileAwal=${1%%.*}

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
#### soal2_enkripsi.sh
* Cara menggunakan `bash soal2_enkripsi.sh "NamaFile".txt`
#### Penjelasan
  c. Melakukan pengecekan argumen kembali seperti pekerjaan "b". Lalu menyimpan jam file tersebut dibuat pada variabel jam. Menyimpan alfabet uppercase dan lowercase pada array yang berbeda lalu melakukan operasi penambahan jam pada huruf acuan awal dan akhir yang akan digunakan pada caesar cipher. Menggunakan caesar cipher dengan acuan yang sudah ditentukan untuk huruf uppercase dan lowercase lalu menyimpannya pada variabel NamaFileAkhir. Merename nama_file menjadi NamaFileAKhir.txt dan menampilkan nama file setelah dienkripsi

* `$(date -r $NamaFileAwal.txt +"%H")` digunakan untuk mengambil kapan jam file(parameter) dibuat
* `hurufG=({A..Z})` dan `hurufk=({a..z})` untuk menyimpan array huruf uppercase dan lowercase
* `$(($jam % 26))` dan `$(( $(( $jam + 25 )) % 26 ))` untuk melakukan operasi perhitungan pada alfabet ditambah jam sebagai penentu pola caesar cipher
*  `echo "$NamaFileAwal" | tr [A-Za-z] ["$hurufGawal"-ZA-"$hurufGakhir""$hurufkawal"-za-"$hurufkakhir"]` enkripsi caesar cipher dengan pola yang ditentukan
* `mv $NamaFileAwal.txt $NamaFileAkhir.txt` untuk merename nama menjadi hasil enkripsi

```bash
#!/bin/bash

NamaCrypted=${1%%.*}

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
#### soal2_dekripsi.sh
* Cara menggunakan `bash soal2_dekripsi.sh "NamaFileTerdekripsi".txt`
#### Penjelasan
  d. Membaca argumen pertama (nama file terdekripsi) tanpa format file dibelakangnya lalu disimpan pada variabel NamaCrypted. Lalu menyimpan jam file tersebut dibuat pada variabel jam. Menyimpan alfabet uppercase dan lowercase pada array yang berbeda lalu melakukan operasi penambahan jam pada huruf acuan awal dan akhir yang akan digunakan pada caesar cipher. Menggunakan caesar cipher dengan format `tr x y` yang dibalik menjadi `tr y x`. Merename nama file yang terenkripsi menjadi NameDecrypted.txt dan menampilkan nama file setelah didekripsi
  
### 3. Pembuatan Script untuk Mengunduh Gambar 

#### soal3a.sh
* Pembuatan script dengan Command `wget`.
```
#!/bin/bash

cd /home/fxkevink/Documents/SoalShiftSISOP20_modul1_B02-master/soal3

iter=0
num0=0
while [[ $iter -ne 28 ]]
do
#echo "ping"
wget -O pdkt_Kusuma_$(($iter+1)) https://loremflickr.com/320/240/cat -o temp.log
if [[ $iter -eq $num0 ]]
  then
    grep -r "Location" temp.log > Location.log
    cat temp.log > wget.log
elif [[ $iter -gt $num0 ]]
  then
    grep -r "Location" temp.log >> Location.log
    cat temp.log >> wget.log
fi
let iter++
done

readarray ab < Location.log

```

#### Penjelasan
Menggunakan command `wget` sebagai pengambikan gambar dari url link yang tersedia lalu gambar yang tersedia pada link akan diunduh  dengan menggunakan iterasi utuk pemeriksaan gambar yang telah diunduh. Gambar yag sudah diunduh dan log messages yang ada akan disimpan ke dalam sebuah file `wget.log`. Pada saat pengunduhan, file yang diterima akan dimasukkan ke dalam lokasi (folder kenalan) dan dengan menghasilkan nama file yang baru (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3). Jika belum terdapat file yang baru maka menggunakan syntax
* `grep -r "Location" temp.log > Location.log`
* `cat temp.log > wget.log
Jika sudah ada, maka akan diappend ke file yang sudah ada dengan syntax
* `grep -r "Location" temp.log >> Location.log` 
* `cat temp.log >> wget.log`

#### soal3b
Menggunakan command berikut untuk membuka crontab:
* `crontab -e`

Melakukan input cronjob dengan command sebagai berikut:
* `5 6/8 * * 0-5 /home/fxkevink/soal3.sh`

#### soal3c.sh
* Pembuatan script untuk menngeidentifikasi gambar yang identik.
```
#!/bin/bash

cd /home/fxkevink/Documents/SoalShiftSISOP20_modul1_B02-master/soal3

max=29
for a in {0..28}
do
  for((i=$((a+1)); i<$max; i=i+1))
    do
      nomerA=$(ls -1 kenangan | wc -l)
      nomerB=$(ls -1 duplicate | wc -l)
    if [[ "${ab[$a]}" = "${ab[$i]}" ]]
      then
      # echo pdkt_Kusuma_"$((a+1))"
      # echo duplicate_"$nomerB"
      mv pdkt_Kusuma_"$(($a+1))" duplicate/duplicate_"$(($nomerB+1))".jpeg
      nomerB=$((nomerB + 1))
      break

    elif [[ $(($max-1)) -eq $i ]]
      then
      # echo pdkt_Kusuma_"$((a+1))"
      # echo kenangan_"$nomerA"
      mv pdkt_Kusuma_"$(($a+1))" kenangan/kenangan_"$(($nomerA+1))".jpeg
      nomerA=$((nomerA + 1))
    fi
    done
done

cat wget.log > Backup.log.bak
cat Location.log >> Backup.log.bak
rm temp.log
                                                              52,1          Bot
```

#### Penjelasan
Menggunakan command `wget.log` untuk membuat `location.log`. Mengidentifikasi gambar yang identik dari keseluruhan gambar yang terunduh pada script yang digunakan sebelumnya. Bila terindikasi gambar yang identik dengan gambar sebelumnya, maka gambar yang identik dipindahkan ke dalam folder ./duplicate dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi ekstensi `.log.bak`.

Hal yang diperlukan yaitu dengan memberi penentuan nomor yang terdapat di kenangan dan di duplicate.
* Pada folder kenangan digunakan syntax
`nomerA=$(ls -1 kenangan | wc -l)`
* Pada folder duplicate digunakan syntax
`nomerB=$(ls -1 duplicate | wc -l)`

Berikutnya jika ditemukan indikasi gambar yang sama, maka gambar tersebut akan diberi format filname yang baru dengan format "duplicate_nomor".
* Untuk penomoran pada duplicate dengan syntax
` mv pdkt_Kusuma_"$(($a+1))" duplicate/duplicate_"$(($nomerB+1))".jpeg`
  Pada syntax di atas nama_file akan diganti dengan format `duplicate` dengan diikuti nomor sesuai iterasi.
* Untuk penomoran pada kenangan menggunakan syntax
` mv pdkt_Kusuma_"$(($a+1))" kenangan/kenangan_"$(($nomerA+1))".jpeg`
  Pada syntax di atas nama_file akan tetap sama denga format yang ada diikuti dengan penomoran sesuai iterasi.
  
Selanjutnya, untuk menyimpan isi dari `wget.log` dan location.log menjadi `Backup.log.bak` serta  menghapus `temp.log` dengan syntax
```
cat wget.log > Backup.log.bak
cat Location.log >> Backup.log.bak
rm temp.log
```
