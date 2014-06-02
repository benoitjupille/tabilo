/*------------------------------------------- LIBRAIRIES */
import org.puredata.processing.PureData;

/*------------------------------------------- OBJETS */
PureData pd;
Master master;
ArrayList<Musicbox> boxes;
ArrayList<Modulo> modulos;
ArrayList<General> generals;

/*------------------------------------------- PROGRAMME */

void setup() {
  // Pure Data
  pd = new PureData(this, 44100, 0, 2);
  pd.openPatch("tabilo.pd");
  pd.start();
  
  // Graphisme
  size(displayWidth, displayHeight);
  smooth(2);
  frameRate(30);
  
  // Constructeurs Objets
  boxes = new ArrayList<Musicbox>();
  modulos = new ArrayList<Modulo>();
  generals = new ArrayList<General>();
  
  master = new Master();
  master.setPosition(width / 2, height / 2); // On place le Master au centre
  
  /* Generals */
  // General 0 : tempo
  generals.add(new General("Tempo"));
  generals.get(0).initPosition((width/2)-60, height/2);
  generals.get(0).setRangeX(30, 300);
  generals.get(0).setForce(4);
  generals.get(0).setAffichage(35, color(63, 76, 107), color(255, 255, 255), 1);
  
  /* Musicboxes */
  // Musicbox 0 : oscillateur
  boxes.add(new Musicbox("osc1"));
  boxes.get(0).initPosition(195, 195);
  boxes.get(0).setForce(4);
  boxes.get(0).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(0).satellites.add(new Satellite("Cutoff"));
  boxes.get(0).satellites.add(new Satellite("Delay"));
  boxes.get(0).satellites.get(1).setValeur(0);
  boxes.get(0).satellites.get(1).setCouleur(color(0, 168, 171));

  // modulo1 linkedTo oscillateur 1 : notes
  modulos.add(new Modulo("modulo1"));
  modulos.get(0).autoPosition(boxes.get(0), 4);
  modulos.get(0).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 3);
  modulos.get(0).setLinkedTo(0);
  modulos.get(0).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 1 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(1).autoPosition(boxes.get(0), 3);
  modulos.get(1).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(1).setLinkedTo(0);
  
  
  // Musicbox 1 : oscillateur 2
  boxes.add(new Musicbox("osc2"));
  boxes.get(1).initPosition(60, 195);
  boxes.get(1).setForce(4);
  boxes.get(1).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(1).satellites.add(new Satellite("Cutoff"));
  boxes.get(1).satellites.add(new Satellite("Delay"));
  boxes.get(1).satellites.get(1).setValeur(0);
  boxes.get(1).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo oscillateur 2
  modulos.add(new Modulo("modulo1"));
  modulos.get(2).autoPosition(boxes.get(1), 4);
  modulos.get(2).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 2);
  modulos.get(2).setLinkedTo(1);
  modulos.get(2).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 2 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(3).autoPosition(boxes.get(1), 3);
  modulos.get(3).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(3).setLinkedTo(1);
  
  
  // Musicbox 2 : oscillateur 3
  boxes.add(new Musicbox("osc3"));
  boxes.get(2).initPosition(195, 60);
  boxes.get(2).setForce(4);
  boxes.get(2).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(2).satellites.add(new Satellite("Cutoff"));
  boxes.get(2).satellites.add(new Satellite("Delay"));
  boxes.get(2).satellites.get(1).setValeur(0);
  boxes.get(2).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo oscillateur 3
  modulos.add(new Modulo("modulo1"));
  modulos.get(4).autoPosition(boxes.get(2), 1);
  modulos.get(4).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 2);
  modulos.get(4).setLinkedTo(2);
  modulos.get(4).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 2 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(5).autoPosition(boxes.get(2), 2);
  modulos.get(5).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(5).setLinkedTo(2);
  
  
  // Musicbox 3 : oscillateur 4
  boxes.add(new Musicbox("osc4"));
  boxes.get(3).initPosition(60, 60);
  boxes.get(3).setForce(4);
  boxes.get(3).setAffichage(35, color(229, 121, 30), color(229, 121, 30), 8);
  boxes.get(3).satellites.add(new Satellite("Cutoff"));
  boxes.get(3).satellites.add(new Satellite("Delay"));
  boxes.get(3).satellites.get(1).setValeur(0);
  boxes.get(3).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo oscillateur 4
  modulos.add(new Modulo("modulo1"));
  modulos.get(6).autoPosition(boxes.get(3), 1);
  modulos.get(6).setAffichage(35, color(250, 250, 250), color(229, 121, 30), 2);
  modulos.get(6).setLinkedTo(3);
  modulos.get(6).setGrilleNotesX(32);
  
  // modulo2 linkedTo oscillateur 2 : X=decay Y=Attack
  modulos.add(new Modulo("modulo2"));
  modulos.get(7).autoPosition(boxes.get(3), 2);
  modulos.get(7).setAffichage(35, color(250, 250, 250), color(90, 71, 29), 3);
  modulos.get(7).setLinkedTo(3);
  
  // Musicbox
  // Musicbox 4 : kick1
  boxes.add(new Musicbox("kick1"));
  boxes.get(4).initPosition(160, height-160);
  boxes.get(4).setForce(0.5);
  boxes.get(4).satellites.add(new Satellite("Delay"));
  boxes.get(4).satellites.get(0).setValeur(0);
  boxes.get(4).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 5 : kick2
  boxes.add(new Musicbox("kick2"));
  boxes.get(5).initPosition(60, height-160);
  boxes.get(5).setForce(0.5);
  boxes.get(5).satellites.add(new Satellite("Delay"));
  boxes.get(5).satellites.get(0).setValeur(0);
  boxes.get(5).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 6 : kick3
  boxes.add(new Musicbox("kick3"));
  boxes.get(6).initPosition(160, height-60);
  boxes.get(6).setForce(0.5);
  boxes.get(6).satellites.add(new Satellite("Delay"));
  boxes.get(6).satellites.get(0).setValeur(0);
  boxes.get(6).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 7 : kick4
  boxes.add(new Musicbox("kick4"));
  boxes.get(7).initPosition(60, height-60);
  boxes.get(7).setForce(0.5);
  boxes.get(7).satellites.add(new Satellite("Delay"));
  boxes.get(7).satellites.get(0).setValeur(0);
  boxes.get(7).satellites.get(0).setCouleur(color(0, 168, 171));
  
  // Musicbox 8 : perc1
  boxes.add(new Musicbox("perc1"));
  boxes.get(8).initPosition(width-160, height-160);
  boxes.get(8).setForce(7);
  boxes.get(8).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(8).satellites.add(new Satellite("Cutoff"));
  boxes.get(8).satellites.get(0).setValeur(127);
  boxes.get(8).satellites.add(new Satellite("Delay"));
  boxes.get(8).satellites.get(1).setValeur(0);
  boxes.get(8).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 1
  modulos.add(new Modulo("modulo1"));
  modulos.get(8).autoPosition(boxes.get(8), 1);
  modulos.get(8).setAffichage(35, color(250, 250, 250), color(76, 184, 72), 2);
  modulos.get(8).setLinkedTo(8);
  
  // Musicbox 9 : perc2
  boxes.add(new Musicbox("perc2"));
  boxes.get(9).initPosition(width-60, height-160);
  boxes.get(9).setForce(7);
  boxes.get(9).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(9).satellites.add(new Satellite("Cutoff"));
  boxes.get(9).satellites.get(0).setValeur(127);
  boxes.get(9).satellites.add(new Satellite("Delay"));
  boxes.get(9).satellites.get(1).setValeur(0);
  boxes.get(9).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 2
  modulos.add(new Modulo("modulo1"));
  modulos.get(9).autoPosition(boxes.get(9), 2);
  modulos.get(9).setAffichage(35, color(250, 250, 250), color(76, 184, 72), 2);
  modulos.get(9).setLinkedTo(9);
  
  // Musicbox 10 : perc3
  boxes.add(new Musicbox("perc3"));
  boxes.get(10).initPosition(width-160, height-60);
  boxes.get(10).setForce(7);
  boxes.get(10).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(10).satellites.add(new Satellite("Cutoff"));
  boxes.get(10).satellites.get(0).setValeur(127);
  boxes.get(10).satellites.add(new Satellite("Delay"));
  boxes.get(10).satellites.get(1).setValeur(0);
  boxes.get(10).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 3
  modulos.add(new Modulo("modulo1"));
  modulos.get(10).autoPosition(boxes.get(9), 3);
  modulos.get(10).setAffichage(35, color(250, 250, 250), color(76, 184, 72), 2);
  modulos.get(10).setLinkedTo(10);
  
  // Musicbox 11 : perc4
  boxes.add(new Musicbox("perc4"));
  boxes.get(11).initPosition(width-60, height-60);
  boxes.get(11).setForce(7);
  boxes.get(11).setAffichage(35, color(76, 184, 72), color(0, 114, 45), 8);
  boxes.get(11).satellites.add(new Satellite("Cutoff"));
  boxes.get(11).satellites.get(0).setValeur(127);
  boxes.get(11).satellites.add(new Satellite("Delay"));
  boxes.get(11).satellites.get(1).setValeur(0);
  boxes.get(11).satellites.get(1).setCouleur(color(0, 168, 171));
  
  // modulo1 linkedTo perc 3
  modulos.add(new Modulo("modulo1"));
  modulos.get(11).autoPosition(boxes.get(9), 4);
  modulos.get(11).setAffichage(35, color(250, 250, 250), color(76, 184, 72), 2);
  modulos.get(11).setLinkedTo(11);
}

void draw(){
  background(255);
  
  master.render();
  
  Musicbox box;
  Modulo mod;
  General general;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    box.ralentit();
    box.render();
    box.setVolume(master.vecteur);
  }
  
  for(int i=0; i<modulos.size(); i++){
    mod = modulos.get(i);
    mod.ralentit();
    mod.render(boxes.get(mod.linkedTo));
  }
  
  for(int i=0; i<generals.size(); i++){
    general = generals.get(i);
    general.ralentit();
    general.render();
  }
}

/*------------------------------------------- FUNCTIONS */

void mousePressed(){
  Musicbox box;
  Modulo mod;
  General general;
  Satellite sat;
  int oneIsLocked = 0;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    if(box.over() && oneIsLocked == 0){
      box.locked = true;
      box.resetvitesse();
      oneIsLocked = 1;
    }else{
      for(int j=0; j<box.satellites.size(); j++){
        sat = box.satellites.get(j);
        if(sat.overSatellite()){
          sat.locked = true;
        }
      }
    }
  }
  
  for(int i=0; i<modulos.size(); i++){
    mod = modulos.get(i);
    if(mod.over() && oneIsLocked == 0){
      mod.resetvitesse();
      mod.locked = true;
      oneIsLocked = 1;
    }
  }
  
  for(int i=0; i<generals.size(); i++){
    general = generals.get(i);
    if(general.over() && oneIsLocked == 0){
      general.resetvitesse();
      general.locked = true;
      oneIsLocked = 1;
    }
  }
}

void mouseDragged(){
  Musicbox box;
  Modulo mod;
  General general;
  Satellite sat;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    if(box.locked){
      box.calculeVitesse(mouseX, mouseY);
      box.setPosition(mouseX, mouseY);
    }else{
      for(int k=0; k<box.satellites.size(); k++){
        sat = box.satellites.get(k);
        if(sat.locked){
          sat.setValeurParPosition();
          if(sat.nom=="Delay"){
            sat.midiToMs(generals.get(0).valeurX);
          }
        }
      }
    }
  }
  
  for(int i=0; i<modulos.size(); i++){
    mod = modulos.get(i);
    if(mod.locked){
      mod.calculeVitesse(mouseX, mouseY);
      mod.setPosition(mouseX, mouseY);
    }
  }
  
  for(int i=0; i<generals.size(); i++){
    general = generals.get(i);
    if(general.locked){
      general.calculeVitesse(mouseX, mouseY);
      general.setPosition(mouseX, mouseY);
    }
  }
}

void mouseReleased(){
  Musicbox box;
  Modulo mod;
  General general;
  Satellite sat;
  
  for(int i=0; i<boxes.size(); i++){
    box = boxes.get(i);
    box.calculeCible(mouseX, mouseY);
    box.locked = false;
    for(int j=0; j<box.satellites.size(); j++){
      sat = box.satellites.get(j);
      sat.locked = false;
    }
  }
  
  for(int i=0; i<modulos.size(); i++){
    mod = modulos.get(i);
    mod.calculeCible(mouseX, mouseY);
    mod.locked = false;
  }
  
  for(int i=0; i<generals.size(); i++){
    general = generals.get(i);
    general.calculeCible(mouseX, mouseY);
    general.locked = false;
  }
}

boolean sketchFullScreen() {
  return false;
}

