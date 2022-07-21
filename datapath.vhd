library ieee;
use ieee.std_logic_1164.all;

entity datapath is

   port(
		input_vector: in std_logic_vector(1 downto 0));
		
end entity;

architecture processor_instance of datapath is 


component master_controller IS
			PORT (
					instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
					op_code : IN STD_LOGIC_VECTOR (3 DOWNTO 0 ); 
				func : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
					reset, clock, zero, carry, reg_inv, is_reg_set : IN STD_LOGIC;
					
					control_signals : OUT STD_LOGIC_vector(27 DOWNTO 0));
END component ;
	

component memory is 
	port(

address  : in std_logic_vector(15 downto 0);
	
		
	data_out : out std_logic_vector(15 DOWNTO 0);
	data_IN   : in std_logic_vector(15 DOWNTO 0);
	 wrt  : in std_logic;
		 rst : in std_logic; 
		 clk : in std_logic); 
end component ;


	
component	alu is
port(
  alu_A, alu_B: in std_logic_vector(15 downto 0);
  output: out std_logic_vector(15 downto 0);
  cin : in std_logic;
  sel : in std_logic_vector (1 downto 0);
  CY, Z: out std_logic);
end component;
	
component inst_register is
	port ( i : IN STD_LOGIC_VECTOR(15 downto 0);
			inst_read : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;
				ir_11_9 : OUT STD_LOGIC_VECTOR(2 downto 0);
				ir_8_6 : OUT STD_LOGIC_VECTOR(2 downto 0);
				ir_5_0 : OUT STD_LOGIC_VECTOR(5 downto 0);
				ir_8_0 : OUT STD_LOGIC_VECTOR(8 downto 0);
				ir_5_3 : OUT STD_LOGIC_VECTOR(2 downto 0));
end component ;

component Regfile_wren is

	port (RF : IN STD_LOGIC_VECTOR(2 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);
        R0_en, R1_en, R2_en, R3_en, R4_en, R5_en, R6_en, R7_en : OUT STD_LOGIC
        );
		  
end component ;

component register_set is
	port (a_1 : IN STD_LOGIC_VECTOR(2 downto 0);
	a_2 : IN STD_LOGIC_VECTOR(2 downto 0);
	a_3 : IN STD_LOGIC_VECTOR(2 downto 0);
	d_3 : IN STD_LOGIC_VECTOR(15 downto 0);
	d_1 : out STD_LOGIC_VECTOR(15 downto 0);
	d_2 : out STD_LOGIC_VECTOR(15 downto 0);
	clk : in std_logic ;
	rst : in std_logic ;
	rf_control_bit : IN STD_LOGIC_VECTOR(2 downto 0));
end component;

component register_16bit is
	port (d : IN STD_LOGIC_VECTOR(15 downto 0);
				wrt : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;
				q : OUT STD_LOGIC_VECTOR(15 downto 0));
end component;


component Regs_sel is
	port (Imm_reg : STD_LOGIC_VECTOR(7 downto 0);

				Reg_num : OUT STD_LOGIC_VECTOR(2 downto 0);
        Num_Invalid : OUT STD_LOGIC);
end component;

component mux2into1 is
port(zero,one:in std_logic_vector(15 downto 0);
     output:out std_logic_vector(15 downto 0); 
     sel:in std_logic);
end component;

component mux3into1 is
port(two,one,zero:in std_logic_vector(15 downto 0);
     output:out std_logic_vector(15 downto 0); 
     sel:in std_logic_vector(1 downto 0));
end component;

component mux4to1 is
port(three,two,one,zero:in std_logic_vector(15 downto 0);
     output:out std_logic_vector(15 downto 0); 
     sel:in std_logic_vector(1 downto 0));
end component;

component convert6to16bit is
	port (input : IN STD_LOGIC_VECTOR(5 downto 0);

				output : OUT STD_LOGIC_VECTOR(15 downto 0));
end component ;


component SignExtended9 is
	port (input : IN STD_LOGIC_VECTOR(8 downto 0);

				output : OUT STD_LOGIC_VECTOR(15 downto 0));
end component;

component lsi is
	port ( 
				lsi_input : IN STD_LOGIC_VECTOR(15 downto 0);
				lsi_output : OUT STD_LOGIC_VECTOR(15  downto 0));
end component;

component framework is
    port (
  F0: in std_logic;
  F1: in std_logic;
  c : in std_logic;
  z : in std_logic;
  alu_inv: in std_logic;
  op_code : in std_logic_vector(3 downto 0);
  t : in std_logic_vector(4 downto 0);
  final_out : out std_logic_vector(1 downto 0));

  end component ;
	
	

	
SIGNAL 	ir_signal_11_9 :  std_logic_vector( 2 downto 0) ;
SIGNAL 	ir_signal_8_6 :  std_logic_vector( 2 downto 0) ;
SIGNAL 	ir_signal_5_0 :  std_logic_vector( 5 downto 0) ;
SIGNAL 	ir_signal_8_0 :  std_logic_vector( 8 downto 0) ;
SIGNAL 	ir_signal_5_3 :  std_logic_vector( 2 downto 0) ;
SIGNAL 	controller_output :  std_logic_vector( 27 downto 0) ;

signal zero_flag : std_logic ;
signal carry_flag : std_logic ;
signal carry_flag_out : std_logic ;
signal reg_inv_flag : std_logic ;
signal reg_set_flag : std_logic ;

signal a_1_signal : std_logic_vector( 2 downto 0 ) ;
signal a_2_signal : std_logic_vector( 2 downto 0 ) ;
signal a_3_signal : std_logic_vector( 2 downto 0 ) ;
signal d_3_signal : std_logic_vector( 15 downto 0 ) ;
signal d_2_signal : std_logic_vector( 15 downto 0 ) ;
signal d_1_signal : std_logic_vector( 15 downto 0 ) ;


signal RS_signal : std_logic_vector( 2 downto 0 ) ;

signal sign_9_signal : std_logic_vector( 15 downto 0 ) ;
signal sign_6_signal : std_logic_vector( 15 downto 0 ) ;
signal t1_input : std_logic_vector( 15 downto 0 ) ;
signal t2_input : std_logic_vector( 15 downto 0 ) ;
signal t3_input : std_logic_vector( 15 downto 0 ) ;
signal pc_input : std_logic_vector( 15 downto 0 ) ;
signal mem_data_input : std_logic_vector( 15 downto 0 ) ;
signal mem_add_input : std_logic_vector( 15 downto 0 ) ;
signal alu_a_input : std_logic_vector( 15 downto 0 ) ;
signal alu_b_input : std_logic_vector( 15 downto 0 ) ;



signal alu_output : std_logic_vector( 15 downto 0 ) ;
signal mem_d_output : std_logic_vector( 15 downto 0 ) ;
signal t1_output : std_logic_vector( 15 downto 0 ) ;
signal t2_output : std_logic_vector( 15 downto 0 ) ;
signal t3_output : std_logic_vector( 15 downto 0 ) ;
signal pc_output : std_logic_vector( 15 downto 0 ) ;
signal lsi_output : std_logic_vector( 15 downto 0 ) ;


signal frame_work_output : std_logic_vector( 1 downto 0 ) ;


	
begin

   controller : master_controller
			port map (
					-- order of inputs Cin B A
					
					instruction(15 downto 0) => mem_d_output,
					op_code(3 downto 0) => mem_d_output(15 downto 12),
					func(1) => input_vector(1),
					func(0) => input_vector(0),
				   reset => input_vector(1),
					clock => input_vector(0),
					zero => zero_flag,
					carry => carry_flag,
					reg_inv => reg_inv_flag,
					is_reg_set => reg_set_flag,
					
					control_signals(27 downto 0) => controller_output );
					
	instruction_recorder : inst_register 
	port map ( i => mem_d_output,
			inst_read => controller_output(27),
				clr => input_vector(1),
				clk  => input_vector(0),
				ir_11_9 => ir_signal_11_9,
				ir_8_6  => ir_signal_8_6,
				ir_5_0  => ir_signal_5_0,
				ir_8_0  => ir_signal_8_0,
				ir_5_3  => ir_signal_5_3);
				
			
register_file : register_set 
	port map (a_1 => a_1_signal ,
	a_2 => a_2_signal,
	a_3 => a_3_signal,
	d_3 =>  d_3_signal ,
	d_1 =>  d_1_signal ,
	d_2 =>  d_2_signal ,
	clk => input_vector(0) ,
	rst => input_vector(1) ,
	rf_control_bit => controller_output(24 downto 22));


	
memory_element :  memory  
	port map (

		address => mem_add_input , 
		data_out => mem_d_output ,
		data_IN => mem_data_input , 
		wrt => controller_output(26),
		rst => input_vector(1), 
		clk => input_vector(0) ); 


		
t1 :  register_16bit
	port map (d =>  t1_input ,
				wrt => controller_output(2),
				clr => input_vector(1),
				clk => input_vector(0),
				q =>  t1_output);
				
t2 :  register_16bit
	port map (d =>  t2_input ,
				wrt => controller_output(1),
				clr => input_vector(1),
				clk => input_vector(0),
				q =>  t2_output);
				
t3 :  register_16bit
	port map (d =>  alu_output ,
				wrt => controller_output(25),
				clr => input_vector(1),
				clk => input_vector(0),
				q =>  t3_output);

				
pc :  register_16bit
	port map (d => pc_input ,
				wrt => controller_output(20),
				clr => input_vector(1),
				clk => input_vector(0),
				q =>  pc_output);

		
alu_element : 	alu 
port map (
  alu_A => alu_a_input ,
  alu_B => alu_b_input ,
  output => alu_output ,
  cin => carry_flag ,
  sel => frame_work_output,
  CY =>   carry_flag_out ,
  Z => zero_flag );

 

 
register_selector : Regs_sel 
port map  (Imm_reg => ir_signal_8_0( 7 downto 0) ,

				Reg_num => RS_signal ,
        Num_Invalid => reg_inv_flag );
	
	
a1_mux : mux2into1 
port map (
      zero(2 downto 0) => ir_signal_8_6 ,
      one(2 downto 0) => ir_signal_11_9 ,
     output(2 downto 0) => a_1_signal , 
     sel =>  controller_output(19) );
	  
a2_mux : mux2into1 
port map (
      zero(2 downto 0) => ir_signal_8_6 ,
      one(2 downto 0) => rs_signal ,
     output(2 downto 0) => a_2_signal , 
     sel =>  controller_output(18) );
	  
t1_mux : mux2into1 
port map (
      zero => sign_9_signal ,
      one=> d_1_signal ,
     output => t1_input , 
     sel =>  controller_output(15) );
	  
pc_mux : mux2into1 
port map (
      zero => d_1_signal  ,
      one=> alu_output ,
     output => pc_input , 
     sel =>  controller_output(10) );
	  
memory_data_mux : mux2into1 
port map (
      zero => d_2_signal  ,
      one=> d_1_signal ,
     output => mem_data_input , 
     sel =>  controller_output(5) );

	  
rs_data_mux : mux3into1
port map(two => mem_d_output,
			one => t3_output ,
			zero => t1_output,
			output => d_3_signal , 
			sel => controller_output(12 downto 11));
			
t2_mux : mux3into1
port map(two => sign_6_signal,
			one => d_2_signal ,
			zero => alu_output,
			output => t2_input , 
			sel => controller_output(14 downto 13));
			
mem_add_mux : mux3into1
port map(two => t2_output,
			one => pc_output ,
			zero => t3_output,
			output => mem_add_input  , 
			sel => controller_output(4 downto 3));
			
alu_a_mux : mux3into1
port map(two => pc_output,
			one => d_1_signal ,
			zero => t1_output,
			output => alu_a_input  , 
			sel => controller_output( 9 downto 8));
			
a3_mux : mux4to1 
port map (three (2 downto 0) =>  rs_signal,
				two(2 downto 0) => ir_signal_8_6 ,
				one(2 downto 0) => ir_signal_5_3 ,
				zero(2 downto 0) => ir_signal_11_9 ,
     output(2 downto 0) => a_3_signal , 
     sel => controller_output(17 downto 16));


			
alu_b_mux : mux4to1
port map (three  =>  sign_6_signal,
				two => t2_output ,
				one => sign_9_signal ,
				zero => lsi_output ,
     output => alu_b_input , 
     sel =>  controller_output  (7 downto 6));
		

lsi_element : lsi 
port map( 
				lsi_input => t2_output,
				lsi_output => lsi_output);

sign_9_element :	SignExtended9 
port map (input => ir_signal_8_0,

				output => sign_9_signal);

sign_6_element : convert6to16bit 
port map (input => ir_signal_5_0,

				output => sign_6_signal);
				
				
framework_dp : framework 
    port map (
  F0 => mem_d_output(0),
  F1  => mem_d_output(1),
  c =>  carry_flag ,
  z => zero_flag ,
  alu_inv => controller_output  (24) ,
  op_code => mem_d_output(15 downto 12) ,
  t => mem_d_output(15 downto 11) ,
  final_out  => frame_work_output );



end processor_instance;