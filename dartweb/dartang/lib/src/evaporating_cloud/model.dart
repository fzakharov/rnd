class LogicalEntity{
  String content;
 
  LogicalEntity(this.content);
}

class EvaporatingCloudLogicalEntity extends LogicalEntity {
  LogicalEntity objective;
  
  EvaporatingCloudLogicalEntity(String content) : super(content);
}

class PremiseLogicalEntity extends LogicalEntity{
  LogicalEntity from;
  LogicalEntity to;

  PremiseLogicalEntity(String content, this.from, this.to) : super(content);
}