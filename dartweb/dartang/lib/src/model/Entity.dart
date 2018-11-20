class Entity {
  String expression;
}

class StatementEntity extends Entity {}

class EnterEntity extends Entity {
  StatementEntity to;
}

class LinkEntity extends Entity {
  StatementEntity to;
  StatementEntity from;

  LinkEntity(this.from, this.to);
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
  EnterEntity objectiveEnter = new EnterEntity();
  EnterEntity bNeedEnter = new EnterEntity();
  EnterEntity cNeedEnter = new EnterEntity();
  LinkEntity abLink;
  LinkEntity bdLink;

  LinkEntity acLink;
  LinkEntity cdAltLink;
  LinkEntity ddAltLink;

  EvaporatingCloud() {
    objectiveEnter.to = objective;
    bNeedEnter.to = bNeed;
    cNeedEnter.to = cNeed;
    abLink = new LinkEntity(objective, bNeed);
    bdLink = new LinkEntity(bNeed, dWant);

    acLink = new LinkEntity(objective, cNeed);
    cdAltLink = new LinkEntity(cNeed, dAltWant);
    ddAltLink = new LinkEntity(dWant, dAltWant);

    objectiveEnter.expression = "Для того, чтобы";
    objective.expression = "цель";
    abLink.expression = "мы должны";
    bNeed.expression = "условие";
    acLink.expression = "мы должны";
    cNeed.expression = "условие";

    bNeedEnter.expression = "Для того, чтобы";
    bdLink.expression = "мы должны";
    dWant.expression = "делать";

    cNeedEnter.expression = "Для того, чтобы";
    cdAltLink.expression = "мы должны";
    dAltWant.expression = "делать";

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
    exp.add(cloud.objective);
    exp.add(cloud.abLink);
    exp.add(cloud.bNeed);

    return exp;
  }
}

class ACValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  ACValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.objectiveEnter);
    exp.add(cloud.objective);
    exp.add(cloud.acLink);
    exp.add(cloud.cNeed);

    return exp;
  }
}

class BDValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  BDValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.bNeedEnter);
    exp.add(cloud.bNeed);
    exp.add(cloud.bdLink);
    exp.add(cloud.dWant);

    return exp;
  }
}

class CDAltValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  CDAltValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.cNeedEnter);
    exp.add(cloud.cNeed);
    exp.add(cloud.cdAltLink);
    exp.add(cloud.dAltWant);

    return exp;
  }
}

class DDAltValidationExpression implements ValidationExpression {
  EvaporatingCloud cloud;

  DDAltValidationExpression(EvaporatingCloud this.cloud);

  List<Entity> getExpressionChain() {
    final List<Entity> exp = [];
    exp.add(cloud.dWant);
    exp.add(cloud.ddAltLink);
    exp.add(cloud.dAltWant);

    return exp;
  }
}
