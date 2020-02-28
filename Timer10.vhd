library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Timer10 is
	
	port(clk    : in std_logic;
		  dataIn : in std_logic_vector(4 downto 0) := "01010";
		  enable : in std_logic;
		  ready : out std_logic;
		  cntOut : out std_logic_vector(4 downto 0));
		  
end Timer10;

architecture Behavioral of Timer10 is
	
	signal s_cntValue : unsigned(4 downto 0) := "01010";
	
begin

	process(clk)
	
	begin
		
		if(rising_edge(clk)) then
			if(enable = '1') then
				s_cntValue <= s_cntValue - 1;
				if(s_cntValue = "00000") then
					ready <= '1';
					s_cntValue <= "00000";
				end if;
			elsif(enable = '0') then
				s_cntValue <= "01010";
			end if;
		end if;
	end process;
	
	cntOut <= std_logic_vector(s_cntValue);

end Behavioral;