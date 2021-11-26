module alu_tb();

logic clk;
logic [31:0] op1, op2;
logic Add, Sub, Mul, Div, Unsigned, WriteHi, WriteLo;
logic Or, And, Xor, Sl, Sr, Arithmetic, Boolean;
logic [31:0] alu_out;
logic n, z, eq;
logic [31:0] hi, lo; 

initial begin
  clk = 0;
  repeat (200) begin
    #2;
    clk = !clk;
  end
  $finish(0);
end

alu dut(
  .clk(clk),
  .op1(op1),
  .op2(op2),
  .Add(Add),
  .Sub(Sub),
  .Mul(Mul),
  .Div(Div),
  .Unsigned(Unsigned),
  .WriteHi(WriteHi),
  .WriteLo(WriteLo),
  .Or(Or),
  .And(And),
  .Xor(Xor),
  .Sl(Sl),
  .Sr(Sr),
  .Arithmetic(Arithmetic),
  .Boolean(Boolean),
  .alu_out(alu_out),
  .n(n),
  .z(z),
  .eq(eq),
  .hi(hi),
  .lo(lo)
);

logic [63:0] temp;

initial begin
  //ADDIU / ADDU
  @(negedge clk);
  op1 = 5204;
  op2 = 3024;
  Add = 1;
  
  @(posedge clk);
  #1;
  assert(alu_out == (op1 + op2)) $display("%d + %d = %d", op1, op2, alu_out); else $error("expected: %d; received: %d", op1 + op2, alu_out);

  //AND
  @(negedge clk);
  op1 = 32'h12345678;
  op2 = 32'h12345678;
  Add = 0;
  And = 1;

  @(posedge clk);
  #1;
  assert(alu_out == (op1 & op2)) $display("%h & %h = %h", op1, op2, alu_out); else $error("expected: %h, received: %h", op1 & op2, alu_out);

  //EQUAL
  @(negedge clk);
  op1 = 58294;
  op2 = 58294;
  And = 0;

  @(posedge clk);
  #1;
  assert(eq == 1) $display("%d = %d", op1, op2); else $error("expected: %d, received: %d", op1 == op2, eq);

  //GREATER THAN 0
  @(negedge clk);
  op1 = 254;

  @(posedge clk);
  #1;
  assert(n == 0 && z == 0) $display("%d > 0", op1); else $error("expected: %d, received: %d", op1 > 0, !(n || z));

  //LESS THAN 0
  @(negedge clk);
  op1 = -425;

  @(posedge clk);
  #1;
  assert(n == 1) $display("%d < 0", op1); else $error("expected: %d, received: %d", op1 < 0, n);

  //NOT EQUAL
  @(negedge clk);
  op1 = 24;
  op2 = 42;

  @(posedge clk);
  #1;
  assert(eq == 0) $display("%d != %d", op1, op2); else $error("expected: %d, received: %d", op1 != op2, !eq);

  //DIVIDE SIGNED: POS / NEG
  @(negedge clk);
  op1 = 2452;
  op2 = -24;
  Div = 1;

  @(posedge clk);
  #1;
  assert($signed(lo) == ($signed(op1) / $signed(op2)) && $signed(hi) == ($signed(op1) % $signed(op2))) $display("%d / %d: quotient = %d, remainder = %d", op1, op2, $signed(lo), $signed(hi)); else $error("expected quotient: %d, received quotient: %d; expected remainder: %d, received remainder: %d", ($signed(op1) / $signed(op2)), $signed(lo), ($signed(op1) % $signed(op2)), $signed(hi));

  //DIVIDE SIGNED: NEG / POS
  @(negedge clk);
  op1 = -2452;
  op2 = 24;

  @(posedge clk);
  #1;
  assert($signed(lo) == ($signed(op1) / $signed(op2)) && $signed(hi) == ($signed(op1) % $signed(op2))) $display("%d / %d: quotient = %d, remainder = %d", op1, op2, $signed(lo), $signed(hi)); else $error("expected quotient: %d, received quotient: %d; expected remainder: %d, received remainder: %d", ($signed(op1) / $signed(op2)), $signed(lo), ($signed(op1) % $signed(op2)), $signed(hi));

  //DIVIDE SIGNED: NEG / NEG
  @(negedge clk);
  op1 = -2452;
  op2 = -24;

  @(posedge clk);
  #1;
  assert($signed(lo) == ($signed(op1) / $signed(op2)) && $signed(hi) == ($signed(op1) % $signed(op2))) $display("%d / %d: quotient = %d, remainder = %d", op1, op2, $signed(lo), $signed(hi)); else $error("expected quotient: %d, received quotient: %d; expected remainder: %d, received remainder: %d", ($signed(op1) / $signed(op2)), $signed(lo), ($signed(op1) % $signed(op2)), $signed(hi));

  //DIVIDE SIGNED: POS / POS
  @(negedge clk);
  op1 = 2452;
  op2 = 24;

  @(posedge clk);
  #1;
  assert($signed(lo) == ($signed(op1) / $signed(op2)) && $signed(hi) == ($signed(op1) % $signed(op2))) $display("%d / %d: quotient = %d, remainder = %d", op1, op2, $signed(lo), $signed(hi)); else $error("expected quotient: %d, received quotient: %d; expected remainder: %d, received remainder: %d", ($signed(op1) / $signed(op2)), $signed(lo), ($signed(op1) % $signed(op2)), $signed(hi));

  //DIVIDE UNSIGNED:
  @(negedge clk);
  op1 = 572;
  op2 = 5294;
  Unsigned = 1;

  @(posedge clk);
  #1;
  assert(lo == (op1 / op2) && hi == (op1 % op2)) $display("%d / %d: quotient = %d, remainder = %d", op1, op2, lo, hi); else $error("expected quotient: %d, received quotient: %d; expected remainder: %d, received remainder: %d", op1 / op2, lo, op1 % op2, hi);

  //MOVE TO HI
  @(negedge clk);
  op1 = 3576;
  Unsigned = 0;
  Div = 0;
  WriteHi = 1;

  @(posedge clk);
  #1;
  assert(hi == op1) $display("hi = %d", op1); else $error("expected: %d, received: %d", op1, hi);

  //MOVE TO LO
  @(negedge clk);
  op1 = 258;
  WriteHi = 0;
  WriteLo = 1;

  @(posedge clk);
  #1;
  assert(lo == op1) $display("lo = %d", op1); else $error("expected: %d, received: %d", op1, lo);

  //MULTIPLY SIGNED: POS * NEG
  @(negedge clk);
  op1 = 28562;
  op2 = -292;
  WriteLo = 0;
  Mul = 1;
  temp = $signed(op1) * $signed(op2);

  @(posedge clk);
  #1;
  assert( $signed({hi, lo}) == $signed(temp) )
  $display( "%d * %d = %d", $signed(op1), $signed(op2), $signed({hi, lo}) ); 
  else $error("expected: %d, received: %d", $signed(temp), $signed({hi, lo}) );

  //MULTIPLY SIGNED: NEG * POS
  @(negedge clk);
  op1 = -28562;
  op2 = 292;
  temp = $signed(op1) * $signed(op2);

  @(posedge clk);
  #1;
  assert( $signed({hi, lo}) == $signed(temp) )
  $display( "%d * %d = %d", $signed(op1), $signed(op2), $signed({hi, lo}) ); 
  else $error("expected: %d, received: %d", $signed(temp), $signed({hi, lo}) );

  //MULTIPLY SIGNED: NEG * NEG
  @(negedge clk);
  op1 = -28562;
  op2 = -292;
  temp = $signed(op1) * $signed(op2);

  @(posedge clk);
  #1;
  assert( $signed({hi, lo}) == $signed(temp) )
  $display( "%d * %d = %d", $signed(op1), $signed(op2), $signed({hi, lo}) ); 
  else $error("expected: %d, received: %d", $signed(temp), $signed({hi, lo}) );

  //MULTIPLY SIGNED: POS * POS
  @(negedge clk);
  op1 = 28562;
  op2 = 292;
  temp = $signed(op1) * $signed(op2);

  @(posedge clk);
  #1;
  assert( $signed({hi, lo}) == $signed(temp) )
  $display( "%d * %d = %d", $signed(op1), $signed(op2), $signed({hi, lo}) ); 
  else $error("expected: %d, received: %d", $signed(temp), $signed({hi, lo}) );

  //MULTIPLY UNSIGNED
  @(negedge clk);
  op1 = 28562;
  op2 = 292;
  Unsigned = 1;

  @(posedge clk);
  #1;
  assert(
    {hi, lo} == temp
  ) 
  $display(
    "%d * %d = %d", op1, op2, (
      (hi << 32) + lo
    )
  ); 

  else $error(
    "expected: %d, received: %d",
    $signed(temp),
    $signed({hi, lo})
  );
  //OR
  @(negedge clk);
  op1 = 32'b10011100001111100000011111110000;
  op2 = 32'b10101010101010101010101010101010;
  Unsigned = 0;
  Mul = 0;
  Or = 1;

  @(posedge clk);
  #1;
  assert(alu_out == (op1 | op2)) $display("%b | %b = %b", op1, op2, alu_out); else $error("expected: %b, received: %b", op1 | op2, alu_out);

  //SHIFT LEFT LOGICAL
  @(negedge clk);
  op1 = 32'b10011100001111100000011111110000;
  op2 = 18;
  Or = 0;
  Sl = 1;

  @(posedge clk);
  #1;
  assert(alu_out == (op1 << op2)) $display("%b << %b = %b", op1, op2, alu_out); else $error("expected: %b, received: %b", op1 << op2, alu_out);

  //SHIFT RIGHT LOGICAL
  @(negedge clk);
  op1 = 32'b10011100001111100000011111110000;
  op2 = 18;
  Sl = 0;
  Sr = 1;

  @(posedge clk);
  #1;
  assert(alu_out == (op1 >> op2)) $display("%b >> %b = %b", op1, op2, alu_out); else $error("expected: %b, received: %b", op1 >> op2, alu_out);

  //SHIFT RIGHT ARITHMETIC
  @(negedge clk);
  op1 = 32'b10011100001111100000011111110000;
  op2 = 18;
  Arithmetic = 1;

  @(posedge clk);
  #1;
  assert(alu_out == $signed($signed(op1) >>> op2)) $display("%b >>> %b = %b", op1, op2, alu_out); else $error("expected: %b, received: %b", $signed(op1) >>> op2, alu_out);

  //SUB 
  @(negedge clk);
  op1 = 275825;
  op2 = 242342;
  Arithmetic = 0;
  Sr = 0;
  Sub = 1;

  @(posedge clk);
  #1;
  assert(alu_out == (op1 - op2)) $display("%d - %d = %d", op1, op2, alu_out); else $error("expected: %d, received: %d", op1 - op2, alu_out);

  //XOR
   @(negedge clk);
  op1 = 32'b10101010101010101010101010101010;
  op2 = 32'b10100101101001011001110000111110;
  Sub = 0;
  Xor = 1;

  @(posedge clk);
  #1;
  assert(alu_out == (op1 ^ op2)) $display("%b ^ %b = %b", op1, op2, alu_out); else $error("expected: %b, received: %b", op1 ^ op2, alu_out);
end

endmodule