module alu (
    input  [7:0] a, b,       
    input  [2:0] op,         
    output reg [7:0] result,
    output           zero,   
    output reg       carry,
    output reg       overflow);

    always @(*) begin
        
        result   = 8'b0;
        carry    = 1'b0;
        overflow = 1'b0;

        case (op)
            3'b000: begin 
                result   = a + b;
                carry    = (a + b > 255);
                overflow = (a[7] == b[7]) && (result[7] != a[7]);
            end
            3'b001: begin
                result   = a - b;
                carry    = (a < b);
                overflow = (a[7] != b[7]) && (result[7] != a[7]);
            end
            3'b010: begin
                result   = a & b;
            end  
            3'b011: begin
                result   = a | b;
            end
            3'b100: begin
                result   = a ^ b;
            end
            3'b101: begin
                result   = a << 1;
                carry    = a[7];
            end   
            3'b110: begin 
                result   = a >> 1;
                carry    = a[0]; 
            end   
            default: begin 
                result   = 8'b0;
                carry    = 1'b0;
                overflow = 1'b0;
            end
        endcase
    end
    assign zero = (result == 8'b0);
endmodule
