library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SYNCHRNZR is
 port (
    CLK: in std_logic;
    ASYNC_IN: in std_logic;
    SYNC_OUT: out std_logic
 );
end SYNCHRNZR;

architecture BEHAVIORAL of SYNCHRNZR is
    signal s_over_flag : std_logic_vector(1 downto 0);
    begin
 process (CLK)
    begin
    
    if rising_edge(CLK) then
        sync_out <= s_over_flag(1);
        s_over_flag<= s_over_flag(0) & async_in;
        
      end if;
 end process;
end BEHAVIORAL;