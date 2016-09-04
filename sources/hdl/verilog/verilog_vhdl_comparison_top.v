// --------------------------------------------------------------------------------
//  Company: 
//  Engineer:
//  
//  Create Date: 03.03.2016 13:25:16
//  Design Name: 
//  Module Name: level_change_domain_top - Behavioral
//  Project Name: 
//  Target Devices: 
//  Tool Versions: 
//  Description: 
//  
//  Dependencies: 
//  
//  Revision:
//  Revision 0.01 - File Created
//  Additional Comments:
//  
//  --------------------------------------------------------------------------------

module verilog_vhdl_comparison_top (signal_in_bit, SystemClk, signal_out_bit);

  //signal_in : in  std_logic_vector(3 downto 0);
  input signal_in_bit;
  input SystemClk;
  //signal_out : out  std_logic_vector(3 downto 0);
  output signal_out_bit;

  parameter number_of_domain_cross_regs = 3; // must be natural number

  reg signal_in_bit_r = 1'b0;
  reg signal_out_bit = 1'b0;
  wire signal_out_bit_s = 1'b0;

//component level_change_domain
//    generic(number_of_domain_cross_regs : natural := 2);
//    Port ( signal_in : in  std_logic_vector;
//           SystemClk : in  std_logic;
//           signal_out : out  std_logic_vector
//           );
//end component;


//initial

always @(posedge SystemClk)
begin 
  signal_in_bit_r <= signal_in_bit;
end


//inst_level_change_domain_bit : level_change_domain
//    generic map(
//            number_of_domain_cross_regs => number_of_domain_cross_regs -- : natural := 2
//            )
//    Port map( 
//            signal_in(0) => signal_in_bit_r,  -- : in  std_logic_vector;
//            SystemClk => SystemClk,         -- : in  std_logic;
//            signal_out(0) => signal_out_bit_s -- : out  std_logic_vector
//           );

assign signal_out_bit_s = signal_in_bit_r;

always @(posedge SystemClk)
begin 
  signal_out_bit <= signal_out_bit_s;
end

//signal_out_bit <= signal_out_bit_r;

//mult_output <= unsigned(input_a) * unsigned(input_b);

endmodule
