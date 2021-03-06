module ApplicationHelper
  def content_type_to_string(content_type)
    mappings = {
      'application/msword' => 'word',
      'application/excel'  => 'excel',
      'text/plain'         => 'text',
      'application/rtf'    => 'text',
      'application/pdf'    => 'pdf'
    }
    mappings[content_type]
  end
end
