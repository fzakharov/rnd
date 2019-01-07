class EntitiesExpressions
{
  String objective="";
  String bNeed="";
  String cNeed="";
  String dWant="";
  String dAltWant="";
}

class LinkExpressions
{
  String objectiveEnter;
  String bNeedEnter;
  String cNeedEnter;
  String abLink;
  String bdLink;

  String acLink;
  String cdAltLink;
  String ddAltLink;

  String dcLink;
  String dAltbLink;
}

class EvaporatingCloudExpressions{
  LinkExpressions links = new LinkExpressions();
  EntitiesExpressions entities = new EntitiesExpressions();
}

class Entity {
  String expression;
}

class StatementEntity extends Entity {}

class EnterEntity extends Entity {
  StatementEntity to;
  EnterEntity(this.to);
}

class LinkEntity extends EnterEntity {
  StatementEntity from;

  LinkEntity(this.from, StatementEntity to) : super(to);
}

class ObjectiveEntity extends StatementEntity {}

class NeedEntity extends StatementEntity {}

class WantEntity extends StatementEntity {}

class EvaporatingCloudEntity extends Entity {
  ObjectiveEntity objective = new ObjectiveEntity();
  NeedEntity bNeed = new NeedEntity();
  NeedEntity cNeed = new NeedEntity();
  WantEntity dWant = new WantEntity();
  WantEntity dAltWant = new WantEntity();
  EnterEntity objectiveEnter;
  EnterEntity bNeedEnter;
  EnterEntity cNeedEnter;
  LinkEntity abLink;
  LinkEntity bdLink;

  LinkEntity acLink;
  LinkEntity cdAltLink;
  LinkEntity ddAltLink;

  LinkEntity dcLink;
  LinkEntity dAltbLink;

  EvaporatingCloudEntity() {
    objectiveEnter = new EnterEntity(objective);
    bNeedEnter = new EnterEntity(bNeed);
    cNeedEnter = new EnterEntity(cNeed);

    abLink = new LinkEntity(objective, bNeed);
    bdLink = new LinkEntity(bNeed, dWant);

    acLink = new LinkEntity(objective, cNeed);
    cdAltLink = new LinkEntity(cNeed, dAltWant);
    ddAltLink = new LinkEntity(dWant, dAltWant);

    dcLink = new LinkEntity(dWant, cNeed);
    dAltbLink = new LinkEntity(dAltWant, bNeed);

    dcLink.expression = dAltbLink.expression = "ставит под угрозу";

    objectiveEnter.expression = "Для того, чтобы";
    objective.expression =
        "CA: Разрабатывать востребованные продукты приносящие финансовую выгоду компании";
    abLink.expression = "мы должны";
    bNeed.expression =
        "CB: Выполнять проекты в срок и в рамках бюджета проекта";
    acLink.expression = "мы должны";
    cNeed.expression =
        "CC: Дорабатывать функциональность по ОС от пользователей";

    bNeedEnter.expression = "Для того, чтобы";
    bdLink.expression = "мы должны";
    dWant.expression =
        "D: Завершать проект по достижению срока или исчерпанию бюджета";

    cNeedEnter.expression = "Для того, чтобы";
    cdAltLink.expression = "мы должны";
    dAltWant.expression = "D': Выполнять итерацию по доработкам";

    ddAltLink.expression = "в конфликте с";
  }

  void Load(EvaporatingCloudExpressions dto){
    var l = dto.links;
    var e =dto.entities;
    
    dcLink.expression = l.dcLink; 
    dAltbLink.expression = l.dAltbLink;

    objectiveEnter.expression = l.objectiveEnter;
    objective.expression =e.objective;
    abLink.expression = l.abLink;
    bNeed.expression =e.bNeed;
    acLink.expression = l.acLink;
    cNeed.expression =e.cNeed;

    bNeedEnter.expression = l.bNeedEnter;
    bdLink.expression = l.bdLink;
    dWant.expression =e.dWant;

    cNeedEnter.expression = e.cNeed;
    cdAltLink.expression = l.cdAltLink;
    dAltWant.expression = e.dAltWant;

    ddAltLink.expression = l.ddAltLink;
  }

  void Save(EvaporatingCloudExpressions dto){
    var l = dto.links;
    var e =dto.entities;
    
    l.dcLink=dcLink.expression; 
    l.dAltbLink=dAltbLink.expression;

    l.objectiveEnter=objectiveEnter.expression;
    e.objective=objective.expression;
    l.abLink=abLink.expression;
    e.bNeed=bNeed.expression;
    l.acLink=acLink.expression;
    e.cNeed=cNeed.expression;

    l.bNeedEnter=bNeedEnter.expression;
    l.bdLink=bdLink.expression;
    e.dWant=dWant.expression;

    e.cNeed=cNeedEnter.expression;
    l.cdAltLink=cdAltLink.expression;
    e.dAltWant=dAltWant.expression;

    l.ddAltLink=ddAltLink.expression;
  }
}