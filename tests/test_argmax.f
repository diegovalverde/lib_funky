use argmax, assert

      test_argmax():
        say('======== test_argmax ========')
        assert(argmax([1,2,7,0,1,5]),2)
        assert(argmax([0,1,0,0,1,2,3,99,0,3]),7)
        assert(argmax([100,1,0,0,1,2,3,99,0,3]),0)
        assert(argmax([100,10,10,1000]),3)
        1.
