#!/usr/bin/env bats

function setup {
  source "$BATS_TEST_DIRNAME/okul"
  unique_csv=$BATS_TEST_DIRNAME/okul.csv
  non_unique_csv=$BATS_TEST_DIRNAME/non_unique.csv
  test_csv=$BATS_TEST_DIRNAME/test.csv
}

@test "is_file_unique() uniq dosya ile başarılı sonuç dönmeli" {
  run is_file_unique $unique_csv 
  [ "$status" -eq 0 ]
}

@test "is_file_unique() uniq olmayan dosya ile başarısız sonuç dönmeli" {
  run is_file_unique $non_unique_csv
  [ "$status" -ne 0 ]
}


@test "arg_control() başarılı sonuç dönmeli" {
  run arg_control 
  [ "$status" -eq 0 ]
}

@test "arg_control() doğru sınıf derecesi ile başarılı sonuç dönmeli" {
  run arg_control 3 
  [ "$status" -eq 0 ]
}

@test "arg_control() doğru cinsiyet ile başarılı sonuç dönmeli" {
  run arg_control k 
  [ "$status" -eq 0 ] 
}

@test "arg_control() birden fazla argüman ile başarısız sonuç dönmeli" {
  run arg_control e 1 
  [ "$status" -ne 0 ] 
}

@test "arg_control() 1'den küçük sınıf derecesi ile başarısız sonuç dönmeli" {
  run arg_control 0 
  [ "$status" -ne 0 ]
}

@test "arg_control() 4'ten büyük sınıf derecesi ile başarısız sonuç dönmeli" {
  run arg_control 7 
  [ "$status" -ne 0 ]
}

@test "run arg_control() e ve k dışındaki harf ile başarısız sonuç dönmeli" {
  run arg_control a 
  [ "$status" -ne 0 ]
}

@test "list_students() tüm öğrenciler için listeleme doğru mu" {
  run list_students $test_csv
  [ "$status" -eq 0 ]
  [ "${lines[5]}" = "2 Mustafa Cemil E" ]
}

@test "list_students() erkek öğrenciler için listeleme doğru mu" {
  run list_students $test_csv e
  [ "$status" -eq 0 ]
  [ "${lines[3]}" = "Mustafa Cemil 2" ]
}

@test "list_students() kız öğrenciler için listeleme doğru mu" {
  run list_students $test_csv k
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "Sevgi Kaya 2" ]
}

@test "list_students() 1. derecedeki öğrenciler için listeleme doğru mu" {
  run list_students $test_csv 1
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Emir Temiz E" ]
}

@test "list_students() 2. derecedeki öğrenciler için listeleme doğru mu" {
  run list_students $test_csv 2
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "Mustafa Cemil E" ]
}

@test "list_students() 3. derecedeki öğrenciler için listeleme doğru mu" {
  run list_students $test_csv 3
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "Irmak Macar K" ]
}

@test "list_students() 4. derecedeki öğrenciler öğrenciler için listeleme doğru mu" {
  run list_students $test_csv 4
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Nalan Ezel K" ]
}



