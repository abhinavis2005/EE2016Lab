module stimulus;

reg [3:0] Multiplier, Multiplicand;
wire [7:0] Output;
wire busy;
reg clk;
reg start;
wire [7:0] count;
wire [3:0] s, d;
initial
begin
    clk <= 0;
end

initial
begin
    $dumpfile("xyz.vcd");
    $dumpvars(0, stimulus);
end

always@(*)
begin
    #1 clk <= ~clk;
end

initial
begin
    $monitor($time, "Multiplier: %d, Multiplicand: %d, Output: %d, busy: %d, clock : %d\n", Multiplier, Multiplicand, Output, busy, count);
end
multiplier mult(Output, busy, Multiplicand, Multiplier, clk, start, count, s, d);

initial
begin
    start = 1;
    #2
    Multiplier = 4'b0010; Multiplicand = 4'b0011;
    #2 start = 0;
    wait(!busy);
    
    #4 $finish;
end
endmodule`



