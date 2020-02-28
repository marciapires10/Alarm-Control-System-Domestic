library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity AlarmSystem is	
	 
	port(arm : in std_logic;
		  clk : in std_logic;
		  windows : in std_logic_vector(3 downto 0);
		  indoor : in std_logic_vector(3 downto 0);
		  panic : in std_logic;
		  pwd : in std_logic;
		  delay : out std_logic;
		  armLED : out std_logic;
		  triggeredLED : out std_logic;
		  alarmOn : out std_logic;
		  sysArm : out std_logic);
		  
end AlarmSystem;

architecture Simple of AlarmSystem is

		type TState is (Unready, Ready, Armed, Triggered, Disarmed);
		signal pState, nState : TState;
		signal s_windows, s_indoor, s_panic, s_spec : std_logic;
		
begin

s_windows <= not windows(0) and not windows(1) and not windows(2) and not windows(3);
s_indoor <= not indoor(0) and not indoor(1) and not indoor(2) and not indoor(3);
s_spec <= not windows(2) and not indoor(2);


MoveState : process(clk)

begin

	if(rising_edge(clk)) then
		pState <= nState;
	end if;

end process;

NextLogic : process(clk)

begin
	
	case pState is
		
		when Unready =>
			if(s_windows = '1' and s_indoor = '1' and s_spec = '1' and panic = '0') then
				nState <= Unready;
			else 
				nState <= Ready;
			end if;
			
		when Ready =>
			if(s_spec = '0' or panic = '1') then 
				nState <= Triggered;
			elsif (s_windows = '0' or s_indoor = '0') then
				nState <= Unready;
			elsif (s_windows = '1' and s_indoor = '1' and s_spec = '1' and panic = '0' and arm = '1') then
				nState <= Armed;
			else
				nState <= Ready;
			end if;
			
		when Armed =>
			if(s_windows = '0' or s_spec = '0' or panic = '1') then
				nState <= Triggered;
			elsif(s_indoor = '0') then
				if(pwd = '1') then
					nState <= Disarmed;
				else
					nState <= Triggered;
				 end if;
			elsif (pwd = '1') then
				nState <= Disarmed;
			else 
				nState <= Armed;
			end if;
			
		when Triggered =>
			if (pwd = '1') then
				nState <= Disarmed;
			else
				nState <= Triggered;
			end if;
			
		when Disarmed =>
			if (s_windows = '1' and s_indoor = '1' and s_spec = '1' and panic = '0') then
				nState <= Unready;
			else
				nState <= Disarmed;
			end if;
		
		end case;
	end process;
	
alarmOn <= '1' when pState = Triggered else '0';
triggeredLED <= '1' when pState = Triggered else '0';
sysArm <= '1' when pState = Armed else '0';
armLED <= '1' when pState = Armed else '0';
delay <= '1' when s_indoor = '0' else '0';

end architecture Simple;