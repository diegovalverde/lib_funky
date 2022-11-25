export var funky_input_buffer=[]
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
        if (Number.isInteger(data)){
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
            str += ']\n'
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
        return new TData(1);
      } else {
        return new TData(this.data.length);
      }

    }
    //-------------------------------------------------------------------------
    //-------------------------------------------------------
    GetRange( ranges_ )  {
				let ranges = JSON.parse(JSON.stringify(ranges_));
        let range = ranges.shift();

        if (this.data.length == 0 ) return new TData([],funky_type.array); //return empty array
        let n = this.data.length;
        let start = (range.start > 0) ? (range.start) % n : (n + range.start) % n;
        let end = (range.end > 0) ? (range.end) % n : (n + range.end) % n;

        if (ranges.length == 0 && !range.isRange && start == end){
            return new TData(this.data[start], funky_type.i32);
        }

				let result = new TData([], funky_type.array);


				for (let i = start; i <= end; i++){

					let element = (ranges.length > 0) ?
						this.data[i].GetRange(ranges) : new TData(this.data[i]);
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
          for (let j = 0; j < flattened.data.length; j++){
            result.data.push( flattened.data[j] );
          }
        }
      }
      return result;
    }
    //-------------------------------------------------------------------------
		Abs() {

     let ret = new TData();
  switch (this.type) {
    case funky_type.i32: ret = new TData(Math.abs(this.data)); break;
    case funky_type.d64: ret = new TData(Math.abs(this.data)); break;
    case funky_type.array: {
			ret = new TData([])
      for (let i = 0; i < this.data.length; i++) {
	      ret.data.push( this.data[i].Abs());
      }
      ret.type = funky_type.array;
      } break;
    default: ret.type = funky_type.invalid;
  }
  return ret;

    }
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
    BroadCastOperation(op,x){
     try {
     if (this.type == funky_type.array && new TData(x).type == funky_type.array){
        if (this.data.length != x.data.length){

	      if (op == '==') return new TData(0);
              if (op == '!=') return new TData(1);
		throw "{op}: array length mismatch between {x}";
        } else if (this.data.length == 0 && x.data.length == 0){
	      if (op == '==') return new TData(1);
              if (op == '!=') return new TData(0);
	}
        let n =  this.data.length;
        let result = new TData([]);
        for (let i = 0; i < n; i++){
            result.data.push( this.data[i].BroadCastOperation(op, x.data[i]) );
        }
				if (op == '==' || op == '!='){
				 if (n == 0){
					 return new TData(1); // [] == []
				 }
				 return new TData(result.data.reduce((a,b) => a * b ));
			 }


        return result;
     } else {
        switch(op){
            case '+': return new TData(this.data + x.data);
            case '-': return new TData(this.data - x.data);
            case '*': return new TData(this.data * x.data);
						case '%': return new TData(this.data % x.data);
						case '==': return new TData((this.data == x.data)? 1 : 0);
					  case '!=': return new TData((this.data != x.data)? 1 : 0);
						case '>': return new TData(this.data >  x.data);
            case '>=': return new TData(this.data >=  x.data);
            case '<': return new TData(this.data <  x.data);
            case '<=': return new TData(this.data <=  x.data);
						case '&&': return new TData(this.data &&  x.data);
						case '||': return new TData(this.data || x.data);
            case '/':
                if (this.type == funky_type.i32 && new TData(x).type == funky_type.i32){
                       return new TData(parseInt(this.data / x.data));
                } else { return new TData(this.data / x.data); }
        }

     }
      } //try
    catch (e){
        funky_console.value += new Error().stack + "msg: " + e.message + "\\n";
        throw e;
     }
    }


};

//-----------------------------------------------------------------------------------
export async function funky_read_file_from_server(path){

			let url='https://jellybytes.dev/pages/funk_online_web_editor/';
		        const result = await $.ajax
		        ({
		                type: "GET",
		                url: url+'funky_example_files/root/' + path,
		        });
	funky_input_buffer = result.split(' ');
	let arr = result.split(/[\n\s]+/g);

	 return arr.filter( e => e != '');
}
//--------------------------------------------------------------------------------------------------
