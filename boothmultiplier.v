module multiplier(prod, busy, mc, mp, clk, start, clock_count, sum, difference);
//mc is the mutiplicand & mp is the multiplier
output [7:0] prod; // ouput 8 bits
output busy;
input [3:0] mc, mp; // input 4 bits
input clk, start;
reg [3:0] A, Q, M; // all registers are of 4 bits
reg Q_1;
reg [2:0] count;
output reg [7:0] clock_count;

initial
begin
clock_count <= 0;
end

assign busy = (count < 4); //essentially finish
assign prod = {A, Q}; // make it fill up the arguments

output wire [3:0] sum, difference;
wire a1, a2;
assign a1 = 1'b0;
assign a2 = 1'b1;
always @(posedge clk)
    begin
    if (start)
    begin
        clock_count <= 1; 
        A <= 4'b0000;
        M <= mc;
        Q <= mp;
        Q_1 <= 0  ; // bit written to the left of lsb of number to be multiplied
        count <= 0;
    end
    else if(busy)
    begin
        clock_count <= clock_count + 1;
        case ({Q[0], Q_1})
            2'b01 : {A, Q, Q_1} <= {sum[3], sum, Q};
            2'b10 : {A, Q, Q_1} <= {difference[3], difference, Q};
            default: {A, Q, Q_1} <= {A[3], A, Q}; 
        endcase
        count <= count + 1'b1;
        end
    end

alu adder(sum, A , M , a1); // adder
alu subtracter(difference , A , ~M, 1'b1); //subtractor using 2's compliment
endmodule
// The following is an alu.It is an adder, but capable of subtraction:
// Recall that subtraction means adding the two's complement-- a - b = a + (-b) = a
//+ (inverted b + 1)
// The 1 will be coming in as cin (carry-in)

module alu(out, a, b, cin);
output [3:0] out;
input [3:0] a;
input [3:0] b;
input cin;
assign out = a + b + cin;
endmodule

