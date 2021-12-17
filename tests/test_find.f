use assert, find

      test_find():
        say('====== test find =====')
        assert(find(7,[1,20,-3,7,200,5]),3) 
        assert(find(1,[1,20,-3,7,200,5]),0) 
        assert(find(20,[1,20,-3,7,200,5]),1) 
        assert(find(70,[1,20,-3,7,200,5]),-1) 
        assert(find(-3,[1,20,-3,7,200,5]),2) 
        assert(find(7,[]),-1) 
        assert(find(7,[1,[],[],7,200,5]),3) 
        1.
