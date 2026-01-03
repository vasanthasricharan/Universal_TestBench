// DESIGN CODE
//Rules
// MODULE_SELECT=0 {"FOR GATES"}
// MODULE_SELECT=1 {"FOR HALF ADDER HALF SUBTRACTOR"}
// MODULE_SELECT=2 {"FOR FULL ADDER FULL SUBTRACTOR"}
// MODULE_SELECT=3 {"FOR 2x1 MULTIPLEXER"}
// MODULE_SELECT=4 {"FOR 4x1 MULTIPLEXER"}

parameter MODULE_SELECT = 0;

//Module 0
module gate(
  input i1, i2,
  output y
);
  assign y = i1 & i2;
endmodule

//module 1
module has(
  input i1, i2,
  output y1, y2
);
  assign y1 = i1 ^ i2;
  assign y2 = i1 & i2;
endmodule

//module 2
module fas(
  input i1, i2, i3,
  output y1, y2
);
  assign y1 = i1^i2^i3;
  assign y2 = (i1&i2) | (i2&i3) | (i3&i1);
endmodule

//module 3
module mux_2x1(
  input d0, d1, 
  input sel,    
  output y      
);
  assign y = sel? d1 : d0;
endmodule

//module 4
module mux_4x1(
  input d0, d1, d2, d3, 
  input [1:0] sel,      
  output reg y          
);
  always @(*) begin
    case(sel)
      2'b00: y = d0;
      2'b01: y = d1;
      2'b10: y = d2;
      2'b11: y = d3;
      default: y = 1'bx;
    endcase
  end
endmodule

//module 5
module decoder3to8 (
    input [2:0] in,    // 3-bit input
    input en,          // enable input
    output reg [7:0] out // 8-bit output
);

always @ (in or en)
begin
    if (en)
        case (in)
            3'b000: out = 8'b00000001;
            3'b001: out = 8'b00000010;
            3'b010: out = 8'b00000100;
            3'b011: out = 8'b00001000;
            3'b100: out = 8'b00010000;
            3'b101: out = 8'b00100000;
            3'b110: out = 8'b01000000;
            3'b111: out = 8'b10000000;
            default: out = 8'b00000000;
        endcase
    else
        out = 8'b00000000; // output is zero when enable is low
end

endmodule