library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EDGEDTCTR is
    port (
        CLK : in  std_logic;
        SYNC_IN : in  std_logic;
        EDGE : out std_logic
    );
end EDGEDTCTR;

architecture BEHAVIORAL of EDGEDTCTR is
    signal sreg : std_logic_vector(2 downto 0);
    signal stable : std_logic := '0';
    signal counter : integer range 0 to 100000 := 0; 
    constant DEBOUNCE_TIME : integer := 100000;       
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if SYNC_IN = stable then
                counter <= 0; 
            else
                counter <= counter + 1;
                if counter = DEBOUNCE_TIME then
                    stable <= SYNC_IN; 
                    counter <= 0;
                end if;
            end if;
            sreg <= sreg(1 downto 0) & stable; 
        end if;
    end process;

    with sreg select
        EDGE <= '1' when "100",
                '0' when others;
end BEHAVIORAL;