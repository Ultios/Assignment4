#!/usr/bin/env bash

echo “Hallo Semua! Script ini hidup!”

#Filter dulu tiap file agar lebih ringan
csvgrep -c event_type -m purchase 2019-Nov-sample.csv | csvcut -c 2-8 > 2019-Nov-sample-purchase.csv
echo “Sukses memfilter 2019 november”
csvgrep -c event_type -m purchase 2019-Oct-sample.csv | csvcut -c 2-8 > 2019-Oct-sample-purchase.csv
echo “Sukses memfilter 2019 oktober”

#Join 2 file
csvstack 2019-Oct-sample-purchase.csv 2019-Nov-sample-purchase.csv > Tugas4SQLraw.csv
echo “Sukses menggabungkan 2 csv”

#Mengambil kategori produk dan nama produk dari kategori kode
csvcut -c 5 Tugas4SQLraw.csv | awk -F '.' '{print$1}' > namaproduk.csv
sed -e '1s/category_code/product_name/' -i '' namaproduk.csv
echo “Sukses mengambil nama produk”

csvcut -c 5 Tugas4SQLraw.csv | awk -F '.' '{print$NF}' > kategoriproduk.csv
sed -e '1s/category_code/category/' -i '' kategoriproduk.csv
echo “Sukses mengambil kategori produk”

#Delete kolom kategori kode
csvcut -c 1,2,3,4,6,7 Tugas4SQLraw.csv > Tugas4SQL.csv
echo "Sukses delete kolom pada kategori kode"

#Gabungin kategorikode produk dan nama produk
paste -d , Tugas4SQL.csv kategoriproduk.csv namaproduk.csv > Tugas4SQLfinal.csv
rm 2019-Nov-sample-purchase.csv 2019-Oct-sample-purchase.csv Tugas4SQLraw.csv namaproduk.csv kategoriproduk.csv Tugas4SQL.csv
echo "It's done!!!"
