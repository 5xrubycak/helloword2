module SetboxesHelper
  def translate_text(text)
      project_id = ENV["CLOUD_PROJECT_ID"]
      target = "zh-tw"
      translate = Google::Cloud::Translate.new project: project_id
      translation = translate.translate text, to: target  
  end
end
