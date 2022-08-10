export const funky_type = {
  invalid : 'invalid',
  array : 'array',
  i32 : 'i32',
  d64 : 'd64',
  str : 'str',
  function : 'function'
};

export class RangeType{
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
    constructor(data=null){
	if (data == null){
		this.type = funky_type.invalid;
		this.data = 666;
		return;
	}
    let rtt = typeof(data);
    if (Array.isArray(data)){
        this.type = funky_type.array;
        let array = []
        for (let i = 0; i < data.length; i++){
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
    	this.type = data.type;
	    if (this.type == "array"){
			this.data = Object.assign([],data.data);
	    } else {
		    this.data = data.data;
	    }
    } else {
        this.type = funky_type.invalid;
        this.data = data;
    }
}
    //-------------------------------------------------------------------------
    Print(){
      let str = '';
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
            for (let i = 0; i < this.data.length; i++){
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
        let range = ranges.pop();

        if (this.data.lenght == 0 ) return new TData([],funky_type.array); //return empty array
        let n = this.data.length;
        let start = (range.start > 0) ? (range.start) % n : (n + range.start) % n;
        let end = (range.end > 0) ? (range.end) % n : (n + range.end) % n;

        if (ranges.length == 0 && !range.isRange && start == end){
            return new TData(this.data[start], funky_type.i32);
        }
        let result = new TData([], funky_type.array);
        for (let i = start; i <= end; i++){
          let element = new TData();
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

      let result = new TData([], funky_type.array);
      for (let i = 0; i < this.data.length; i++){
        let flattened = this.data[i].Flatten();
        if (flattened.type != funky_type.array){
          result.data.push( flattened );
        } else {
          for (let j = 0; i < flattened.data.length; j++){
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
    Equals(x){
        if (typeof(x) != "object"){
			return x == this.data;
		}

        if (x.type != this.type){
            return 0;
        }

        switch(this.type){
          case funky_type.array:
            if (x.data.length != this.data.length){
                return 0;
            }

            for (let i = 0; i < this.data.length; i++){
                  if (this.data[i].Equals(x.data[i]) == 0){
                    return 0;
                  }
              }

            break;

          default:
            if (this.data == x.data){
            return 1;
            }
      }
        return 0;
    }
    //-------------------------------------------------------------------------
    Nequals(x){
        if (Equals(x) == 1){
            return 0;
        } else {
            return 1;
        }
    }
    //-------------------------------------------------------------------------


};
