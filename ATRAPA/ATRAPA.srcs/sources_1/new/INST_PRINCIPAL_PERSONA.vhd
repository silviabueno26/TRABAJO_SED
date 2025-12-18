library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity principal_persona is
    Port (
        clk : in  std_logic;
        btn_left : in  std_logic;   
        btn_right : in  std_logic;   
        rst : in  std_logic;
        posicion : out std_logic_vector(14 downto 0)
    );
end principal_persona;

architecture Behavioral of principal_persona is
    signal pos_persona : integer range 0 to 4 := 2;
    signal displays : std_logic_vector(7 downto 0);
    signal segment : std_logic_vector(6 downto 0);

begin

    process(clk, rst)
    begin
        if rst = '0' then
            pos_persona <= 2;  
        elsif rising_edge(clk) then
            if btn_left = '1' and pos_persona > 0 then
                pos_persona <= pos_persona - 1;
            elsif btn_right = '1' and pos_persona < 4 then
                pos_persona <= pos_persona + 1;
            end if;
        end if;
    end process;

    process(pos_persona)
    begin
        displays <= (others => '1');
        displays(pos_persona) <= '0';
        segment <= (others => '1');
        segment(3) <= '0';
    end process;

    posicion <= displays & segment;

end Behavioral;
