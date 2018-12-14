import 'package:dartang/src/model/Entity.dart';

abstract class ValidationExpression {
  List<Entity> getExpressionChain();
}

class EnterValidationExpression implements ValidationExpression {
  List<Entity> exp = [];

  EnterValidationExpression(EnterEntity enter, LinkEntity link) {
    exp.add(enter);
    exp.add(enter.to);
    exp.add(link);
    exp.add(link.to);
  }

  List<Entity> getExpressionChain() {
    return exp;
  }
}

class LinkValidationExpression implements ValidationExpression {
  List<Entity> exp = [];

  LinkValidationExpression(LinkEntity link) {
    exp.add(link.from);
    exp.add(link);
    exp.add(link.to);
  }

  List<Entity> getExpressionChain() {
    return exp;
  }
}

class ABValidationExpression extends EnterValidationExpression {
  ABValidationExpression(EvaporatingCloud cloud)
      : super(cloud.objectiveEnter, cloud.abLink);
}

class ACValidationExpression extends EnterValidationExpression {
  ACValidationExpression(EvaporatingCloud cloud)
      : super(cloud.objectiveEnter, cloud.acLink);
}

class BDValidationExpression extends EnterValidationExpression {
  BDValidationExpression(EvaporatingCloud cloud)
      : super(cloud.bNeedEnter, cloud.bdLink);
}

class CDAltValidationExpression extends EnterValidationExpression {
  CDAltValidationExpression(EvaporatingCloud cloud)
      : super(cloud.cNeedEnter, cloud.cdAltLink);
}

class DDAltValidationExpression extends LinkValidationExpression {
  DDAltValidationExpression(EvaporatingCloud cloud) 
  : super(cloud.ddAltLink);
}

class DCValidationExpression extends LinkValidationExpression {
  DCValidationExpression(EvaporatingCloud cloud) 
  : super(cloud.dcLink);
}

class DAltBValidationExpression extends LinkValidationExpression {
  DAltBValidationExpression(EvaporatingCloud cloud) 
  : super(cloud.dAltbLink);
}
