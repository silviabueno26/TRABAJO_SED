library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- controla velocidad según nivel y elige una posicion aleatoria
entity estados is
    Port (
        clk: in  std_logic;
        reset: in  std_logic;
        nivel1: in  std_logic;
        nivel2: in  std_logic;
        nivel3: in  std_logic;
        posicion_manzana: out std_logic_vector(14 downto 0)
    );
end estados;

architecture Behavioral of estados is
    signal lfsr : std_logic_vector(2 downto 0) := "001";
    --displays de juego. 5=pared, 6-7=contador
    signal display_juego : integer range 0 to 4 := 0;
    signal counter   : integer := 0;
    signal timer_max : integer := 0;
    signal segment  : std_logic_vector(6 downto 0) := (others => '1');
    signal displays : std_logic_vector(7 downto 0) := (others => '1');
    constant CLK_FREQ : integer := 100000000;
    constant TIMER_LENTO  : integer := CLK_FREQ * 2;
    constant TIMER_MEDIO  : integer := CLK_FREQ;
    constant TIMER_RAPIDO : integer := CLK_FREQ /2;
    type manzana_states is (state0, state1, state2);
    signal manzana_estado : manzana_states := state0;

begin
-- LFSR
process(clk, reset)
    begin
        if reset = '0' then
            lfsr <= "001";
        elsif rising_edge(clk) then
            lfsr <= lfsr(1 downto 0) & (lfsr(2) xor lfsr(0));
        end if;
end process;

-- velocidad segun nivel
process(clk, reset)
    begin
        if reset = '0' then
            timer_max <= TIMER_LENTO;
        elsif rising_edge(clk) then
            if nivel1 = '1' then
                timer_max <= TIMER_LENTO;
            elsif nivel2 = '1' then
                timer_max <= TIMER_MEDIO;
            elsif nivel3 = '1' then
                timer_max <= TIMER_RAPIDO;
            else
                timer_max <= TIMER_LENTO;
            end if;
        end if;
    end process;
    
 -- temporizador
process(clk, reset)
    begin
        if reset = '0' then
            counter <= 0;
        elsif rising_edge(clk) then
            if counter >= timer_max then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
end process;

-- caida
process(clk, reset)
        variable rnd : integer range 0 to 4;
    begin
        if reset = '0' then
            manzana_estado <= state0;
            displays <= (others => '1');
            segment  <= (others => '1');
            display_juego <= 0;

        elsif rising_edge(clk) then
            if counter = 0 then
                case manzana_estado is
                    when state0 =>
                        -- elegir display aleatorio 
                        rnd := (to_integer(unsigned(lfsr)) mod 5);
                        display_juego <= rnd;
                        manzana_estado <= state1;
                        displays <= (others => '1');
                        displays(rnd) <= '0';
                        segment  <= (others => '1');
                        segment(6) <= '0';  -- a 

                    when state1 =>
                        manzana_estado <= state2;
                        displays <= (others => '1');
                        displays(display_juego) <= '0';
                        segment  <= (others => '1');
                        segment(0) <= '0';  -- g
                        
                    when state2 =>
                        manzana_estado <= state0;
                        displays <= (others => '1');
                        displays(display_juego) <= '0';
                        segment  <= (others => '1');
                        segment(3) <= '0';  -- d 

                end case;
            end if;
        end if;
end process;
posicion_manzana <= displays & segment;

end Behavioral;