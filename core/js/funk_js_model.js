export const funky_type = {
  invalid : 'invalid',
  array : 'array',
  i32 : 'i32',
  d64 : 'd64',
  str : 'str',
  function : 'function'
};

class RangeType{
      constructor(start, end, isRange){
        this.start = start;
        this.end = end;
        this.isRange = isRange;
      }
      start = 0;
      end = 0;
      isRange = false;
    };

export class TData
{
    constructor(data={}){
      if (data === {}){
        this.type = funky_type.invalid;
        this.type = 666;
      }
      var rtt = typeof(data);
      if (Array.isArray(data)){
        this.type = funky_type.array;
        var array = []
        for (var i = 0; i < data.length; i++){
          array.push(new TData(data[i]));
        }
        this.data = array;
      }
      else if (rtt === "string") {
        this.type = funky_type.str;
        this.data = data;
      }
      else if (rtt === "number") {
        if (!isNaN(parseFloat(data))){
          this.type = funky_type.i32;
          this.data = data;
        } else {
          this.type = funky_type.d64;
          this.data = data;
        }
      }else if (rtt === "function") {
        this.type = funky_type.function;
        this.data = data;
      }else if (rtt === "object") {
        this.type = funky_type.array;
        this.data = data.data;
      } else {
        this.type = funky_type.invalid;
        this.data = data;
      }


    }
    //-------------------------------------------------------------------------
    Print(){
      var str = '';
      switch(this.type){
        case funky_type.i32:
          if (this.data == Number.MAX_SAFE_INTEGER){
            str = "inf";
          } else if (this.data == Number.MIN_SAFE_INTEGER){
            str = "-inf";
          } else {
            str = String(this.data);
          }
          break;
          case funky_type.function: str+="<fn>"; break;
          case funky_type.str:
            str += '\'' + this.data + '\''
          break;
          case funky_type.array:
            str += '[';
            for (var i = 0; i < this.data.length; i++){
                  str += this.data[i].Print();
                  if (i + 1 < this.data.length){
                    str += ', ';
                  }
              }
            str += ']'
            break;
        case funky_type.d64: console.log(this.data); break;
          default:
            str = "[unknown]";
      }

      return str;
    }
    //-------------------------------------------------------------------------
    GetLen(){
      if (this.data.length == undefined){
        return 1;
      } else {
        return this.data.length;
      }

    }
    //-------------------------------------------------------------------------
    //-------------------------------------------------------
    GetRange( ranges )  {
        var range = ranges.pop();

        if (this.data.lenght == 0 ) return TData([],funky_type.array); //return empty array
        var n = this.data.length;
        var start = (range.start > 0) ? (range.start) % n : (n + range.start) % n;
        var end = (range.end > 0) ? (range.end) % n : (n + range.end) % n;

        if (ranges.length == 0 && !range.isRange && start == end){
            return new TData(this.data[start], funky_type.i32);
        }
        var result = new TData([], funky_type.array);
        for (var i = start; i <= end; i++){
          var element = new TData();
          element = (ranges.length > 0) ? this.data[i].GetRange(ranges) : this.data[i];
          if (range.isRange){
            result.data.push(element);
          } else {
            result = element;
          }
        }
        return result;
}
    //-------------------------------------------------------------------------
    Flatten() {
      if (this.type != funky_type.array) return new TData(this.data, this.type);

      var result = new TData([], funky_type.array);
      for (var i = 0; i < this.data.length; i++){
        var flattened = this.data[i].Flatten();
        if (flattened.type != funky_type.array){
          result.data.push( flattened );
        } else {
          for (var j = 0; i < flattened.data.length; j++){
            result.data.push( flattened.data[j] );
          }
        }
      }
      return result;
    }
    //-------------------------------------------------------------------------
    Abs() {}
    //-------------------------------------------------------------------------
    valueOf() {
      // this allows doing the poor man's operator overloading in JS
      return this.data;
    };
    //-------------------------------------------------------------------------
    toString(){
      return this.Print();
    }
    //-------------------------------------------------------------------------

    #type = funky_type.invalid;
    #data;  // the data holder

};
