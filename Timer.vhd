library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Timer is
	
	port(clk    : in std_logic;
		  dataIn : in std_logic_vector(4 downto 0) := "10100";
		  enable : in std_logic;
		  ready : out std_logic;
		  cntOut : out std_logic_vector(4 downto 0));
		  
end Timer;

architecture Behavioral of Timer is
	
	signal s_cntValue : unsigned(4 downto 0) := "10100";
	
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
				s_cntValue <= "10100";
			end if;
		end if;
	end process;
	
	cntOut <= std_logic_vector(s_cntValue);

end Behavioral;