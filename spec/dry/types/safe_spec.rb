RSpec.describe Dry::Types::Definition, '#safe' do
  context 'with a coercible string' do
    subject(:type) { Dry::Types['coercible.string'].constrained(min_size: 5).safe }

    it 'rescues from type-errors and returns input' do
      expect(type['pass']).to eql('pass')
    end

    it 'tries to apply its type' do
      expect(type[:passing]).to eql('passing')
    end

    it 'aliases #[] as #call' do
      expect(type.call(:passing)).to eql('passing')
    end

    describe 'equality' do
      def type
        Dry::Types['coercible.string'].constrained(min_size: 5).safe
      end

      it_behaves_like 'a type with equality defined'
    end
  end

  context 'with a form hash' do
    subject(:type) do
      Dry::Types['form.hash'].weak(age: 'coercible.int', active: 'form.bool')
    end

    it 'applies its types' do
      expect(type[age: '23', active: 'f']).to eql(age: 23, active: false)
    end

    it 'rescues from type-errors and returns input' do
      expect(type[age: 'wat', active: '1']).to eql(age: 'wat', active: true)
    end
  end
end
