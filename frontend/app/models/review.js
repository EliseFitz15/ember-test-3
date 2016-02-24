import DS from 'ember-data';

export default DS.Model.extend({
  book: DS.belongsTo('book'),
  score: DS.attr('number'),
  description: DS.attr('string')
});
