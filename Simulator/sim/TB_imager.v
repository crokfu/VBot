`timescale 1ns /100ps
`include "../src/imager.v"

module test;
reg clk, reset, enable;
wire [7:0] out;

up_counter counter(.out(out), .enable(enable),.clk(clk),.reset(reset));

integer fin, r, fout;
reg [7:0] value;
integer test_counter;
integer position;

initial
begin
	fin = $fopen("hic.bin","r");
	fout = $fopen("hic_out.bin","wb");

	if (fin == 0) begin
		$display("data_file handle was NULL");
	end
	else begin
		$display("data_file handle successful");
	end

	#10 ;
	reset = 1;
	clk = 0;
	#10 ;
	reset = 0;
	enable = 1;
	
end


always @(posedge clk) 
begin
	position = $ftell(fin);

	
	if(reset) begin
		test_counter <= 0;
	end 
	else begin
		r=$fscanf(fin, "%d", value);

		if(!$feof(fin))
		begin
			//position = $ftell(fin);
			$display("count = %d, %d, [position=%d]", test_counter, value,position);			
			test_counter <= test_counter + 1;
			$fwrite(fout,"%d\n", value);
			//$fdisplay(fout,"%d",value); //write as binary
		end
	end

	if($feof(fin))
		begin
		$display("this is done @%d ns",$time);
		//$display("ch count = %d", test_counter);
		//$fclose(fin);
		//$fclose(fout);		
		end


end

always #5 clk = !clk;
 
endmodule
