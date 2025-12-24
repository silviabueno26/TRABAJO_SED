library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder is
    Port(
        clk : in std_logic;
        rst : in std_logic;
        posicion_persona : in std_logic_vector (14 downto 0);
        posicion_manzana : in std_logic_vector (14 downto 0);
        game_over : in std_logic;
        win : in std_logic;
        decenas : in std_logic_vector(3 downto 0); 
        unidades : in std_logic_vector(3 downto 0); 
        leds : out std_logic_vector (14 downto 0)
    );
end decoder;

architecture Behavioral of decoder is

    constant DIV_FACTOR : integer := 100000;
    signal div_counter : integer := 0;
    signal mux_clk : std_logic := '0';
    signal current_display : integer range 0 to 7 := 0;
    constant PARED : std_logic_vector(6 downto 0) := "1111001"; 

    type sel_array is array (0 to 7) of std_logic_vector(7 downto 0);
    constant DIG_SEL : sel_array := (
        0 => "11111110",
        1 => "11111101",
        2 => "11111011",
        3 => "11110111",
        4 => "11101111",
        5 => "11011111",
        6 => "10111111",
        7 => "01111111"
    );
 
    function seg7_digit(d : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable s : std_logic_vector(6 downto 0);
    begin
        case d is
            when "0000" => s := "0000001"; -- 0
            when "0001" => s := "1001111"; -- 1
            when "0010" => s := "0010010"; -- 2
            when "0011" => s := "0000110"; -- 3
            when "0100" => s := "1001100"; -- 4
            when "0101" => s := "0100100"; -- 5
            when "0110" => s := "0100000"; -- 6
            when "0111" => s := "0001111"; -- 7
            when "1000" => s := "0000000"; -- 8
            when "1001" => s := "0000100"; -- 9
            when others => s := "1111111"; -- blanco
        end case;
        return s;
    end function;
    
function digit_active(v : std_logic_vector(14 downto 0); d : integer) return boolean is
    begin
        return (v(7 + d) = '0');
    end function;

begin
    process(clk, rst)
    begin
        if rst = '0' then
            div_counter <= 0;
            mux_clk <= '0';
        elsif rising_edge(clk) then
            if div_counter = DIV_FACTOR then
                div_counter <= 0;
                mux_clk <= not mux_clk;
            else
                div_counter <= div_counter + 1;
            end if;
        end if;
    end process;
   
process(mux_clk, rst)
  variable seg_next : std_logic_vector(6 downto 0);
begin
    if rst = '0' then
        current_display <= 0;
        leds <= (others => '1');
    elsif rising_edge(mux_clk) then
        seg_next := "1111111";
        if game_over = '1' then
            case current_display is
                when 7 => seg_next := "0100001"; -- g
                when 6 => seg_next := "0001000"; -- a
                when 5 => seg_next := "0001001"; -- m
                when 4 => seg_next := "0110000"; -- e
                when 3 => seg_next := "0000001"; -- o
                when 2 => seg_next := "1000001"; -- v
                when 1 => seg_next := "0110000"; -- e
                when 0 => seg_next := "0001000"; -- r
                when others => seg_next := "1111111";
            end case;
            
        elsif win = '1' then
            case current_display is
                when 7 => seg_next := "1000001"; -- v
                when 6 => seg_next := "1111001"; -- i
                when 5 => seg_next := "0110001"; -- c
                when 4 => seg_next := "0001111"; -- t
                when 3 => seg_next := "0000001"; -- o
                when 2 => seg_next := "0001000"; -- r
                when 1 => seg_next := "1111001"; -- i
                when 0 => seg_next := "0001000"; -- a
                when others => seg_next := "1111111";
            end case;
        else
            case current_display is
                when 0 | 1 | 2 | 3 | 4 =>
                    seg_next := "1111111";
                    if digit_active(posicion_manzana, current_display) then
                        seg_next := seg_next and posicion_manzana(6 downto 0);
                    end if;
                    if digit_active(posicion_persona, current_display) then
                        seg_next := seg_next and posicion_persona(6 downto 0);
                    end if;
                when 5 =>
                    seg_next := PARED;
                when 6 =>
                    seg_next := seg7_digit(unidades);
                when 7 =>
                    seg_next := seg7_digit(decenas);
                when others =>
                    seg_next := "1111111";
            end case;
        end if;
        
        leds <= DIG_SEL(current_display) & seg_next;
        
        if current_display = 7 then
            current_display <= 0;
        else
            current_display <= current_display + 1;
        end if;
    end if;
end process;

end Behavioral;