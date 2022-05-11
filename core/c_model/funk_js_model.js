const funky_type = {
  invalid : 'invalid',
  array : 'array',
  i32 : 'i32',
  d64 : 'd64',
  str : 'str',
  function : 'function'
};

class TData
{
    constructor(){}
    //-------------------------------------------------------------------------
    Print(){

      switch($this.type){
        case funky_type.i32:
          if ($this.data == Number.MAX_SAFE_INTEGER){
            console.log("inf");
          } else if ($this.data == Number.MIN_SAFE_INTEGER){
            console.log("-inf");
          } else {
            console.log($this.data);
          }
          break;
          case funky_type.function: oss << "<fn: " << str << ">"; break;
          case funky_type.array:
            process.stdout.write("[");
            for ( i = 0; i < array.size(); i++){
                  process.stdout.write(array[i]);
                  if (i + 1 < array.size()){
                    process.stdout.write(",");
                  } else {
                    process.stdout.write("");
                  }
              }
            console.log("]\n");
            break;
        case funky_type.d64: console.log($this.data); break;
          default:
            console.log("[unknown]");
      }
    }
    //-------------------------------------------------------------------------
    GetLen(){
      if ($this.type == funky_type.array){
        return $this.data.lenght();
      } else {
        return 1;
      }
    }
    //-------------------------------------------------------------------------
    Flatten() { return this.data.flat();}
    //-------------------------------------------------------------------------
    GetRange( ranges ){}
    //-------------------------------------------------------------------------
    Abs() {}
    toString(){
      return Print();
    }
    //-------------------------------------------------------------------------

    #type = funky_type.invalid;
    #data;  // the data holder

};
