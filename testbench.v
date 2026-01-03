// TEST BENCH
module tb;
  reg i_a, i_b, i_c;
  reg i_d;
  reg [1:0] i_sel_mux_4x1;
  reg [2:0] in;         // for decoder input
  reg en;               // enable for decoder
  wire [7:0] out;       // decoder output
  wire o_y1, o_y2;

  generate
    if (MODULE_SELECT == 0) begin : test_gate
      gate u1 (
        .i1(i_a),
        .i2(i_b),
        .y(o_y1)
      );
      initial begin
        $display("--- Testing AND Gate ---");
        $monitor("Time=%0t | i_a=%b, i_b=%b | y=%b", $time, i_a, i_b, o_y1);
        i_a = 0; i_b = 0; #10;
        i_a = 0; i_b = 1; #10;
        i_a = 1; i_b = 0; #10;
        i_a = 1; i_b = 1; #10;
        $finish;
      end

    end else if(MODULE_SELECT == 1) begin : test_has
      has u1 (
        .i1(i_a),
        .i2(i_b),
        .y1(o_y1),
        .y2(o_y2)
      );
      initial begin
        $display("--- Testing Half Adder ---");
        $monitor("Time=%0t | i_a=%b, i_b=%b | Sum=%b, Carry=%b", $time, i_a, i_b, o_y1, o_y2);
        i_a = 0; i_b = 0; #10;
        i_a = 0; i_b = 1; #10;
        i_a = 1; i_b = 0; #10;
        i_a = 1; i_b = 1; #10;
        $finish;
      end

    end else if(MODULE_SELECT == 2) begin : test_fas
      fas u1 (
        .i1(i_a),
        .i2(i_b),
        .i3(i_c),
        .y1(o_y1),
        .y2(o_y2)
      );
      initial begin
        $display("--- Testing Full Adder ---");
        $monitor("| i_a=%b, i_b=%b, i_c=%b | Sum=%b, Carry=%b", i_a, i_b, i_c, o_y1, o_y2);
        i_a = 0; i_b = 0; i_c = 0; #10;
        i_a = 0; i_b = 0; i_c = 1; #10;
        i_a = 0; i_b = 1; i_c = 0; #10;
        i_a = 0; i_b = 1; i_c = 1; #10;
        i_a = 1; i_b = 0; i_c = 0; #10;
        i_a = 1; i_b = 0; i_c = 1; #10;
        i_a = 1; i_b = 1; i_c = 0; #10;
        i_a = 1; i_b = 1; i_c = 1; #10;
        $finish;
      end

    end else if(MODULE_SELECT == 3) begin : test_mux_2x1
      mux_2x1 u1 (
        .d0(i_a),
        .d1(i_b),
        .sel(i_c),
        .y(o_y1)
      );
      initial begin
        $display("--- Testing 2x1 Multiplexer ---");
        $monitor("Time=%0t | d0=%b, d1=%b, sel=%b | y=%b", $time, i_a, i_b, i_c, o_y1);
        i_c = 0; i_a = 1; i_b = 0; #10;
        i_c = 1; i_a = 1; i_b = 0; #10;
        $finish;
      end

    end else if(MODULE_SELECT == 4) begin : test_mux_4x1
      mux_4x1 u1 (
        .d0(i_a),
        .d1(i_b),
        .d2(i_c),
        .d3(i_d),
        .sel(i_sel_mux_4x1),
        .y(o_y1)
      );
      initial begin
        $display("--- Testing 4x1 Multiplexer ---");
        $monitor("Time=%0t | d0=%b, d1=%b, d2=%b, d3=%b, sel=%b | y=%b", $time, i_a, i_b, i_c, i_d, i_sel_mux_4x1, o_y1);
        i_a = 1; i_b = 1; i_c = 1; i_d = 1;
        i_sel_mux_4x1 = 2'b00; #10;
        i_sel_mux_4x1 = 2'b01; #10;
        i_sel_mux_4x1 = 2'b10; #10;
        i_sel_mux_4x1 = 2'b11; #10;
        $finish;
      end

    end else if (MODULE_SELECT == 5) begin : test_decoder3to8
      decoder3to8 u1 (
        .in(in),
        .en(en),
        .out(out)
      );
      initial begin
        $display("--- Testing 3-to-8 Decoder ---");
        $monitor("Time=%0t | in=%b, en=%b | out=%b", $time, in, en, out);
        
        en = 1;
        in = 3'b000; #10;
        in = 3'b001; #10;
        in = 3'b010; #10;
        in = 3'b011; #10;
        in = 3'b100; #10;
        in = 3'b101; #10;
        in = 3'b110; #10;
        in = 3'b111; #10;
        $finish;
      end
    end
  endgenerate
endmodule