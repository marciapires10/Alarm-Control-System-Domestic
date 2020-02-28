library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Shell is 
	
	port(SW : in std_logic_vector(17 downto 0);
		  CLOCK_50 : in std_logic;
		  LEDR : out std_logic_vector(17 downto 0);
		  LEDG : out std_logic_vector(9 downto 0);
		  HEX0 :  out std_logic_vector(6 downto 0);
		  HEX4 : out std_logic_vector(6 downto 0);
		  HEX5 : out std_logic_vector(6 downto 0);
		  HEX6 :  out std_logic_vector(6 downto 0);
		  HEX7 :  out std_logic_vector(6 downto 0));
		  
end Shell;

architecture Shell of Shell is

signal freqDivClk    : std_logic;
signal s_alarmOn, s_armed, s_delay, s_trigg : std_logic;
signal pass : std_logic;
signal s_alarm, s_sysArm : std_logic;
signal const : std_logic_vector(4 downto 0) := "10100";
signal s_attempt : std_logic;
signal ready20, s_ready : std_logic;
signal out20, out10 : std_logic_vector(4 downto 0);
signal s_bcd0, s_bcd1, s_bcd2, s_bcd3 : std_logic_vector(3 downto 0);


begin
	
	
	freqDivider : entity work.FreqDivider(Behavioral)
					  generic map(N => 50000000)
					  port map(clkIn => CLOCK_50,
								  clkOut => freqDivClk);
						
									
	alarm : entity work.AlarmSystem(Simple)
			  port map(arm => ready20,
						  clk => freqDivClk,
						  windows => SW(3 downto 0),
						  indoor => SW(7 downto 4),
						  panic => SW(17),
						  pwd => pass,
						  delay => s_delay,
						  armLED => s_armed,
						  triggeredLED => s_trigg,
						  alarmOn => s_alarm,
						  sysArm => s_sysArm);
						  
						  
	keyComparator : entity work.KeyComparator(Behavioral)
						 port map(clk => freqDivClk,
									 keysIn => SW(11 downto 9),
									 attempt => LEDG(1),
									 pwdOut => pass);
									 
	display7segStates : entity work.Bin7SegStates(Behavioral)
					  port map(alarmOn => s_alarm,
								  alarmOff => not s_alarm,
								  --sysArm => ready20,
								  decOutput => HEX0);
									 
	timer20 : entity work.Timer(Behavioral)
				 port map(clk => freqDivClk,
							 dataIn => "10100",
							 enable => SW(16),
							 ready => ready20,
							 cntOut => out20);
							 
	timer10 : entity work.Timer10(Behavioral)
				 port map(clk => freqDivClk,
							 dataIn => "01010",
							 enable => s_delay,
							 ready => s_ready,
							 cntOut => out10);
							 
	bin2bcd20 : entity work.Bin2BCD(Behavioral)
					port map(bin => out20,
					         bcd0 => s_bcd0,
								bcd1 => s_bcd1);
								
	bin2bcd10 : entity work.Bin2BCD(Behavioral)
					port map(bin => out10,
					         bcd0 => s_bcd2,
								bcd1 => s_bcd3);
								
	display7segDez20 : entity work.Bin7SegDecoder(Behavioral)
						 port map(bcdInput => s_bcd1,
									 decOutput => HEX6);
									 
   display7segDez10 : entity work.Bin7SegDecoder(Behavioral)
						 port map(bcdInput => s_bcd3,
									 decOutput => HEX4);
									 
   display7segUn20 : entity work.Bin7SegDecoder(Behavioral)
						 port map(bcdInput => s_bcd0,
									 decOutput => HEX7);
									 
   display7segUn10 : entity work.Bin7SegDecoder(Behavioral)
						 port map(bcdInput => s_bcd2,
									 decOutput => HEX5);
									 
	blinkOn : entity work.Blink(Behavioral)
				 port map(enable => s_armed,
							 clk => freqDivClk,
							 ledOut => LEDG(0));
							 
	blinkTriggered : entity work.RandomBlink(Behavioral)
						  port map(rst => s_trigg,
									  clk => CLOCK_50,
									  DB => LEDR(17 downto 0));
				
	s_ready <= '1';

end Shell;