Pod::Spec.new do |s|
    s.name         = "TKViewControllerCollectionController"
    s.version      = "0.1.3"
    s.summary      = "A UIViewController container using a UICollectionView for the layout of the views."
    s.homepage     = "https://github.com/anagromataf/TKViewControllerCollectionController"
    
    s.license      = {
        :type => 'BSD',
        :text => <<-LICENSE
        Copyright (c) 2012 Tobias Kräntzer.
        All rights reserved.
        
        Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
        
        • Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
        • Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
        
        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
        LICENSE
    }
    s.author              = { "Tobias Kräntzer" => "info@tobias-kraentzer.de" }
    s.source              = { :git => "https://github.com/anagromataf/TKViewControllerCollectionController.git", :tag => "0.1.3" }
    
    s.platform            = :ios, '6.0'
    s.source_files        = 'TKViewControllerCollectionController/TKViewControllerCollectionController.{h,m}'
    s.public_header_files = 'TKViewControllerCollectionController/TKViewControllerCollectionController.h'
    s.requires_arc        = true
end
