'.source.js':
    'Ext.Msg Async':
        'prefix': 'ext-msg-async',
        'body': '''
Ext.Msg.show({
    title: '$1',
    msg: '$2',
    icon: Ext.Msg.$3,
    buttons: Ext.Msg.$4,
    scope: $4,
    fn: function(btn) {
        $5
    }
});'''
