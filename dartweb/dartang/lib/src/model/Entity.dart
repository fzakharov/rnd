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

class EvaporatingCloud extends Entity {
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

  EvaporatingCloud() {
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
    objective.expression = "CA: Разрабатывать востребованные продукты приносящие финансовую выгоду компании";
    abLink.expression = "мы должны";
    bNeed.expression = "CB: Выполнять проекты в срок и в рамках бюджета проекта";
    acLink.expression = "мы должны";
    cNeed.expression = "CC: Дорабатывать функциональность по ОС от пользователей";

    bNeedEnter.expression = "Для того, чтобы";
    bdLink.expression = "мы должны";
    dWant.expression = "D: Завершать проект по достижению срока или исчерпанию бюджета";

    cNeedEnter.expression = "Для того, чтобы";
    cdAltLink.expression = "мы должны";
    dAltWant.expression = "D': Выполнять итерацию по доработкам";

    ddAltLink.expression = "в конфликте с";
  }
}

abstract class ValidationExpression {
  List<Entity> getExpressionChain();
}

class ABValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  ABValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.objectiveEnter);
    exp.add(cloud.objectiveEnter.to);
    exp.add(cloud.abLink);
    exp.add(cloud.abLink.to);

    return exp;
  }
}

class ACValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  ACValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.objectiveEnter);
    exp.add(cloud.objectiveEnter.to);
    exp.add(cloud.acLink);
    exp.add(cloud.acLink.to);

    return exp;
  }
}

class BDValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  BDValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.bNeedEnter);
    exp.add(cloud.bNeedEnter.to);
    exp.add(cloud.bdLink);
    exp.add(cloud.bdLink.to);

    return exp;
  }
}

class CDAltValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  CDAltValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.cNeedEnter);
    exp.add(cloud.cNeedEnter.to);
    exp.add(cloud.cdAltLink);
    exp.add(cloud.cdAltLink.to);

    return exp;
  }
}

class DDAltValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  DDAltValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.ddAltLink.from);
    exp.add(cloud.ddAltLink);
    exp.add(cloud.ddAltLink.to);

    return exp;
  }
}

class DCValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  DCValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.dcLink.from);
    exp.add(cloud.dcLink);
    exp.add(cloud.dcLink.to);

    return exp;
  }
}

class DAltBValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  DAltBValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.dAltbLink.from);
    exp.add(cloud.dAltbLink);
    exp.add(cloud.dAltbLink.to);

    return exp;
  }
}
