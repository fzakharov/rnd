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
}

class ObjectiveEntity extends StatementEntity {}

class NeedEntity extends StatementEntity {}

class WantEntity extends StatementEntity {}

class EvaporatingCloud extends Entity {
  ObjectiveEntity objective = new ObjectiveEntity();
  NeedEntity bNeed = new NeedEntity();
  NeedEntity cNeed = new NeedEntity();
  WantEntity dWand = new WantEntity();
  WantEntity dAltWant = new WantEntity();
  EnterEntity objectiveEnter = new EnterEntity();
  EnterEntity bNeedEnter = new EnterEntity();
  EnterEntity cNeedEnter = new EnterEntity();

  EvaporatingCloud() {
    objectiveEnter.to = objective;
    bNeedEnter.to = bNeed;
    cNeedEnter.to = cNeed;
  }
}

class ABValidationExpression{
  EvaporatingCloud cloud;

  ABValidationExpression(EvaporatingCloud this.cloud){
  }

  List<Entity> getExpressionChain(){
    final List<Entity> exp = [];
    exp.add(cloud.objectiveEnter);
    exp.add(cloud.objective);
    //exp.add(cloud);

    return exp;
  }
}