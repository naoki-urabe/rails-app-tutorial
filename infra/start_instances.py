import boto3

ec2 = boto3.resource('ec2', 'ap-northeast-1')

def lambda_handler(event, context):
    filters = [{
        'Name': 'tag:AutoStop',
        'Values': ['true']
    },
    {
        'Name': 'instance-state-name',
        'Values': ['stopped']
    }]
    instances = ec2.instances.filter(Filters=filters)
    instance_ids = [instance.id for instance in instances]
    starting_instances = ec2.instances.filter(Filters=[{'Name': 'instance-id', 'Values': instance_ids}]).start()