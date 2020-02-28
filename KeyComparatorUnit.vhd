library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity KeyComparator is 
	
	port(clk : in std_logic;
		  keysIn : in std_logic_vector(11 downto 9);
		  attempt : out std_logic;
		  pwdOut : out std_logic);		  
end KeyComparator;

architecture Behavioral of KeyComparator is

	type TState is (S0, S1, S2, S3, E1, E2, E3);
	signal pState, nState: TState;
	signal s_count : unsigned(1 downto 0);
	
begin 
	
	sync_proc: process(clk)
	
	begin
	
		if(rising_edge(clk)) then
			pState <= nState;
		end if;
	
	end process;
	
	comb_proc: process(pState, keysIn)
	
	begin
	
		case pState is
		
			when S0 => 
				if(keysIn(9) = '1') then
					nState <= S1;
				else
					nState <= E1;
				end if;
				
			when S1 =>
				if((keysIn(9) and keysIn(11)) = '1') then 
					nState <= S2;
				else
					nState <= E2;
				end if;
			
			when S2 =>
				if((keysIn(9) and keysIn(11) and keysIn(10)) = '1') then
					nState <= S3;
				else
					nState <= E3;
				end if;
				
			when S3 =>
				nState <= S0;
				
			when E1 =>
				nState <= E2;
				
			when E2 => 
				nState <= E3;
				
			when E3 => 
				nState <= S0;
				if (s_count < 4) then
					s_count <= s_count + 1;
				end if;
				
			when others =>
				nState <= S0;
				
		end case;

	end process;

pwdOut <= '1' when pState = S3 else '0';
attempt <= '1' when (s_count = 3) else '0';
		
end Behavioral;