LIBRARY ieee;
	USE ieee.std_logic_1164.ALL;
	USE ieee.numeric_std.ALL;
	
	ENTITY master_controller IS
			PORT (
					instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
					op_code : IN STD_LOGIC_VECTOR (3 DOWNTO 0 ); 
				func : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
					reset, clock, zero, carry, reg_inv, is_reg_set : IN STD_LOGIC;
					
					control_signals : OUT STD_LOGIC_vector(27 DOWNTO 0));
	END master_controller;
	
	ARCHITECTURE rch OF master_controller IS
	
			---------------Define state type here-----------------------------
			TYPE state IS ( init ,s1, s2, s3, s4, s6, s7, s8, s9, s10 , s12, s13, s14, s15, s16, s17 , s18);
			---------------Define signals of state type-----------------------
			SIGNAL state_present, state_next : state := s1;
			SIGNAL control_sig : STD_LOGIC_VECTOR(27 DOWNTO 0);
	
	BEGIN
			clock_proc : PROCESS (clock, reset)
			BEGIN
					
					IF (clock = '1' AND clock' event) THEN
					
							
							state_present <= state_next;
				
			
	end if ;
			END PROCESS;
			
			state_transition_proc : PROCESS (state_present , op_code, zero , carry, reg_inv , is_reg_set,func)
			BEGIN 
							CASE state_present IS
								
	
	
	when init => 
	
	state_next <= s1;
	
	WHEN s1 =>
	
               control_sig <= "1100001100000000011000010000";
				 state_next<=s3;

		IF (op_code = "0001") THEN
	
				
                        IF (func = "00") THEN
	
				state_next <= s2;

                        elsif( func = "10" ) then

                               if ( carry = '1') then 

                               state_next <= s2;

                              else 

                              state_next <= s1 ;

                              end if; 

                        elsif ( func = "01") then 

                                    IF( zero = '1') then
						
                                    state_next <= s2;
													
						ELSE 
													
						state_next <= s1 ; 
													
						end if ;
													
				ELSE  
													    
				state_next <= s2;

                        end if ; 
													     


            elsif (op_code = "0000") THEN

            state_next <= s2;

            elsif(op_code = "0010") THEN 

                         IF (func = "00") THEN
	
				state_next <= s2;

                        elsif( func = "10" ) then

                               if ( carry = '1') then 

                               state_next <= s2;

                              else 

                              state_next <= s1 ;

                              end if; 

                        elsif ( func = "01") then 

                                    IF( zero = '1') then
						
                                    state_next <= s2;
													
						ELSE 
													
						state_next <= s1 ; 
													
						end if ;
													
				ELSE  
													    
				state_next <= s2;

                        end if ; 
													     
                                                                        
            elsif ( op_code = "0011") THEN
                                                                        
            state_next <= s7;
                                                                        
            elsif (unsigned(op_code) = 7 or unsigned(op_code) = 5) THEN
                                                                        
            state_next <= s8;

            elsif (unsigned(op_code) = 12 or unsigned(op_code) = 13) THEN
                                                                        
            state_next <= s13;
                                                                        
            elsif (unsigned(op_code) = 8) THEN
                                                                        
            state_next <= s2;

            elsif (unsigned(op_code) = 9) THEN
                                                                        
            state_next <= s17;
                                                                        
            elsif (unsigned(op_code) = 10) THEN
                                                                        
            state_next <= s16;

             elsif (unsigned(op_code) = 11) then
                                                                        
            state_next <= s18;

            else 

            state_next <= s1 ;
																										 
		end if;
                                                      when s2 => 

                                                                  control_sig <= "0001100010001010000000000110";
                                                                  state_next <= s3 ;

                                                      when s3 => 
																		
            control_sig <= "0000001000000000000010000000";
            
            if (unsigned(op_code) = 1 or unsigned(op_code) = 2) then 

             state_next <= s4 ; 

            elsif( unsigned(op_code) = 0 ) then 

            state_next <= s6; 

            elsif( unsigned(op_code) = 7) then 

            state_next <= s9;

             elsif( unsigned(op_code) = 5) then 

            state_next <= s10;

            elsif( unsigned(op_code) = 8) then 
                                                                              
                   if (zero = '0') then
                                                                             
                             state_next <= s1 ;

                else

                              state_next <= s12 ;

                  end if ;
						
				else 
				
				state_next <= s1 ;
                                                                  
             end if;

                                                      when s4 => 
                                                                  
                                                                  control_sig <= "0000010000010000100000000000";
                                                                  state_next <= s1 ;

                                                      when s6 => 
                                                                  
                                                                  control_sig <= "0000010000100001000000000000";
                                                                  state_next <= s1 ;

                                                      when s7 => 

                                                                  control_sig <= "0000010000000001100000000000";
                                                                  state_next <= s1 ;

                                                      when s8 => 

                                                                 control_sig <= "0001000000001100000000000110";
                                                                  state_next <= s3 ;

                                                      when s9 => 

                                                                  control_sig <= "0100010000000001000000000000";
                                                                  state_next <= s1 ;

                                                      when s10 => 

                                                                  control_sig <= "0011000010000000000000100000";
                                                                  state_next <= s1 ;

                                                      when s12 => 

                                                                  control_sig <= "0000001100000000011011000000";
                                                                  state_next <= s1 ;

                                                      when s13 => 
      control_sig <= "0000000000000000000000000001";

                  if(reg_inv = '1') then 

                        state_next <= s1 ; 

                  else 

                        if(is_reg_set = '1') then 

                        state_next <= s14;

                        else 

                        state_next <= s13 ;

                        end if ;

                  end if ; 

                                                      when s14 => 
      control_sig <= "0100011000110001000010010010";

                  if(reg_inv = '0' )then 

                   state_next <= s13 ;

                  else 
                                                        
                  state_next <= s1 ;

                  end if ; 

                                                      when s15 => 

                                                      control_sig <= "0010101001000000000000010110";

                  if(reg_inv = '0' )then 

                   state_next <= s13 ;

                  else 
                                                        
                  state_next <= s1 ;

                  end if ; 
                                                      
                                                      when s16 => 

                                                                   control_sig <= "0001010100000001000000000000";
                                                                   state_next <= s1 ;

                                                      when s17 => 

                                                                  control_sig <= "0000011100000001011001000000";
                                                                  state_next <= s1 ;

                                                      when s18 => 

																		
                                                                  control_sig <= "0000011100000001011001000000";
                                                                  state_next <= s1 ;
	

	
							END CASE;
	
			END PROCESS;
	
			control_signals <= control_sig;
	
	END rch;