require 'spec_helper'

describe Task do
  context 'demonstration of how datamapper works' do
    it 'should be created and then retrieved from the database' do
      expect(Task.count).to eq(0)

      Task.create(complete: false,
                  description: 'create to do app')

      expect(Task.count).to eq(1)

      task = Task.first

      expect(task.complete).to eq false
      expect(task.description).to eq 'create to do app'

      task.destroy

      expect(Task.count).to eq(0)
    end
  end
end
