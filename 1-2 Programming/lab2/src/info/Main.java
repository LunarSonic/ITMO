package info;
import ru.ifmo.se.pokemon.*;
import info.pokemons.*;
public class Main {
    public static void main(String[] args) {
        Battle b = new Battle();
        TapuBulu p1 = new TapuBulu("Awesome", 1);
        Glameow p2 = new Glameow("Wonderful", 1);
        Purugly p3 = new Purugly("Strong", 1);
        Bounsweet p4 = new Bounsweet("Cute", 1);
        Steenee p5 = new Steenee("Stunning", 1);
        Tsareena p6 = new Tsareena("Amazing", 1);
        b.addAlly(p1);
        b.addAlly(p2);
        b.addAlly(p3);
        b.addFoe(p4);
        b.addFoe(p5);
        b.addFoe(p6);
        b.go();
    }
}
