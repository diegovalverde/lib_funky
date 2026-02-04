use assert, fread_list

test_file_read():
      say('==== test_file_read ====')
      assert(fread_list('funk/tests/test_file_read.txt'), [1,2,3,4,5,6,7,8,9,10])
      1.
